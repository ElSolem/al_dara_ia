import os
import math
import subprocess
import cmath
import json

def ZerothInit(x: float) -> bool:
    now = os.times()[4]  # user + system time
    w = 2.0 * math.pi
    t_c = complex(now, 0.0)

    fibprime = 2.971215073e9
    theta = math.pi * now
    ei = complex(math.cos(theta), math.sin(theta))
    ei_mag = abs(ei.real) + abs(ei.imag)
    max_ = int(fibprime * now * math.pi * ei_mag)

    wt_abs = abs(w * x)

    # Core expressions
    e1 = complex(wt_abs, wt_abs) * t_c
    e2 = complex(0.0, wt_abs ** 2) * t_c
    e3 = complex(-wt_abs ** 2, 0.0) * t_c
    e4 = complex(wt_abs, -wt_abs) * t_c

    # No try/catch — zero allowed, let math decide
    log_val = math.log(wt_abs, 2) if wt_abs > 0 else 0.0
    exp_angle = wt_abs * log_val
    e5 = complex(math.cos(exp_angle), math.sin(exp_angle)) * t_c

    y = x
    xt = float(x) * now
    yt = float(y) * now
    e6 = (abs(xt) + abs(yt)) <= 1.0

    angle = w * x
    e7 = complex(math.cos(angle), math.sin(angle)) * t_c

    abs_diff = (abs(float(x)) - abs(float(y))) * now
    e8 = abs_diff >= 0.0

    c = ((abs(e1.real) > 0.5 or abs(e1.imag) > 0.5) or
         (abs(e2.real) > 0.5 or abs(e2.imag) > 0.5) or
         (e3.real < 0.0) or (e4.imag < 0.0) or
         (e5.real > 0.0 and e5.imag > 0.0) or
         e6 or (e7.real > 0.0 and e7.imag > 0.0) or
         e8)

    return c

def update_apt():
    print("\n📦 [APT] Zeroth Update Initiated")
    subprocess.run(['sudo', 'apt', 'update'])
    output = subprocess.check_output(['apt', 'list', '--upgradable'], text=True)
    lines = output.strip().split('\n')[1:]

    for line in lines:
        pkg = line.split('/')[0]
        x = sum(ord(c) for c in pkg)
        if ZerothInit(x):
            print(f"↑ Upgrading {pkg}")
            subprocess.run(['sudo', 'apt', 'install', '--only-upgrade', '-y', pkg])
        else:
            print(f"⛔ Skipped by Zeroth field: {pkg}")

def update_pip():
    print("\n🐍 [PIP] Zeroth Update Initiated")
    pkgs_json = subprocess.check_output(['pip', 'list', '--outdated', '--format=json'], text=True)
    pkgs = json.loads(pkgs_json)

    for pkg_info in pkgs:
        pkg = pkg_info['name']
        x = sum(ord(c) for c in pkg)
        if ZerothInit(x):
            print(f"↑ Upgrading {pkg}")
            subprocess.run(['pip', 'install', '--upgrade', pkg])
        else:
            print(f"⛔ Skipped by Zeroth field: {pkg}")

def main():
    update_apt()
    update_pip()
    print("\n✅ Zeroth system update complete.")

if __name__ == "__main__":
    main()
