import os, glob, sys
a = [f for f in glob.glob("*") if not os.path.isdir(f)]
for line in sys.stdin.read().split("\n"):
	line = line.split(" ")
	if len(line) < 3: continue
	id = line[2]
	for i in range(len(a)):
		if id in a[i]:
			del a[i]
			break
for f in a:
	print(f)
