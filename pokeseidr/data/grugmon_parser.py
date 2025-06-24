
import re
from pathlib import Path

def parse_generic_pbs_sections(text: str, section_label: str) -> str:
    entries = text.strip().split("#-------------------------------")
    output = []

    for entry in entries:
        lines = [line.strip() for line in entry.strip().splitlines() if line.strip() and not line.strip().startswith("#")]
        if not lines:
            continue

        header_match = re.match(r"\[(.+?)\]", lines[0])
        if not header_match:
            continue
        header = header_match.group(1)
        fields = lines[1:]

        output.append(f'{section_label} "{header.title()}" {{')
        for field in fields:
            if "=" not in field:
                continue
            key, value = [x.strip() for x in field.split("=", 1)]
            key_norm = key.lower().replace(" ", "_")

            if "," in value and not key.lower() in ("description", "formname"):
                values = [v.title().replace("_", "") for v in value.split(",")]
                output.append(f'    {key_norm}: {values}')
            elif key.lower() == "description":
                output.append(f'    description: "{value.strip()}"')
            else:
                try:
                    if "." in value:
                        num_val = float(value)
                        output.append(f'    {key_norm}: {num_val}')
                    else:
                        num_val = int(value)
                        output.append(f'    {key_norm}: {num_val}')
                except ValueError:
                    output.append(f'    {key_norm}: "{value.strip().title()}"')
        output.append("}\n")

    return "\n".join(output)

if __name__ == "__main__":
    import sys
    input_file = sys.argv[1]
    section_label = sys.argv[2]
    output_file = sys.argv[3]

    text = Path(input_file).read_text(encoding="utf-8")
    result = parse_generic_pbs_sections(text, section_label)
    Path(output_file).write_text(result, encoding="utf-8")
