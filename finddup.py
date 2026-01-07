#!/usr/bin/env python3
import os, glob, subprocess
s = set()
for f in glob.glob("*/*"):
	target = os.readlink(f)
	if target in s:
		id = f[::-1].split(".",2)[1][:11][::-1]
		subprocess.call(["xdg-open", "https://youtube.com/watch?v=" + id])
		input(id + ": ")
	s.add(target)
