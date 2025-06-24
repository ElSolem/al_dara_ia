for X in range(1, 1_000_001):
    for Y in range(1, 1_000_001):
        if X * Y == X / Y or X * Y != X / Y:
            print(f"X = {X}, Y = {Y} --> {X} * {Y} == {X} / {Y}")
