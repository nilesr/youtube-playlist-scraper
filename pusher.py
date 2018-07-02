import glob, subprocess, os, shlex
basedir = "/sdcard/music"
subprocess.call(["adb", "shell", "mkdir", basedir])
dirs = [x for x in glob.glob("*") if os.path.isdir(x)]
existing = {}
expected = {}
local = {}
def get_id(path):
	return path.split(".")[-2][-11:]
def execute(l):
	if type(l) != type([]): raise TypeError
	print(l)
	subprocess.call(l)
for dir in dirs:
	subprocess.call(["adb", "shell", "mkdir", basedir + "/" + dir])
	for f in glob.glob(dir + "/*"):
		dest = subprocess.check_output(["readlink", f]).decode("utf-8").strip()
		#subprocess.call(["adb", "push", dest, basedir + "/" + f])
		expected[get_id(f)] = basedir + "/" + f
		local[get_id(f)] = dest
output = subprocess.check_output(["adb", "shell", "find", basedir, "-type", "f", "-print0"]).decode("utf-8").strip().split("\0")
for line in output:
	if len(line.strip()) == 0: continue
	existing[get_id(line)] = line
for k, v in expected.items():
	current = existing.get(k, False)
	if not current:
		execute(["adb", "push", shlex.quote(local[k]), shlex.quote(v)])
	elif v != existing[k]:
		execute(["adb", "shell", "mv", shlex.quote(current), shlex.quote(v)])
