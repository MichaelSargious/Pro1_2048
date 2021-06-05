#! /usr/bin/env python3

import sys
import os
import argparse
import subprocess
from  subprocess import TimeoutExpired
from  subprocess import CalledProcessError

sources = "src/util.asm src/check.asm src/buffer.asm src/merge.asm src/move_check.asm src/move_left.asm src/complete_move.asm " +\
            "src/move_one.asm src/place.asm src/printboard.asm src/points.asm"

def find_tests(dir):
    tests = []
    for t in os.listdir(dir):
        if t.endswith('.asm'):
            tests.append(dir + "/" + t.replace('.asm', ''))
    tests.sort()
    return tests

def check(test):
    test = test.replace('asm','').replace('ref','')

    if not os.path.isfile(test + ".asm"):
        sys.stderr.write("Test file missing for test " + test + "\n")
        return None

    if not os.path.isfile(test + ".ref"):
        sys.stderr.write("Reference file missing for test " + test + "\n")
        return None

    try:
        stdout_file = open("stdout.log", 'w+')
        stderr_file = open("stderr.log", 'w+')
        proc = subprocess.run(["./mars", "ae127", "se126", "me", "nc", "sm", "100000", sources, test + ".asm"],
                   stdout=stdout_file,  stderr=stderr_file, timeout=100, check=True)
        #stdout_file.write("\n")

    except TimeoutExpired:
        sys.stderr.write("error: timeout expired\n")
        return None

    except CalledProcessError as error:
        if error.returncode == 126:
            sys.stderr.write("error: runtime failure, error message was: \n" + open('stderr.log').read() + "\n")
            return None

        if error.returncode == 127:
            sys.stderr.write("error: assembler failed, error message was: \n" + open('stderr.log').read() + "\n")
            return None

        sys.stderr.write("error: mars terminated with value " + error.returncode + ", error message was: \n" + error.stderr + "\n")
        return None

    diff_proc = subprocess.run(["diff", "--strip-trailing-cr", "-q", test + ".ref", "stdout.log"])

    if diff_proc.returncode == 0:
        print("success")
        return True
    else:
        print("failed: result differs")
        print("Expected:")
        print(open(test + ".ref").read())
        print("Was:")
        print(open('stdout.log').read())
        return False


parser = argparse.ArgumentParser()
parser.add_argument('-t', help='execute only the specified test')
parser.add_argument('--student', action='store_true', help='excutes all self written tests in the folder tets/student')
args = parser.parse_args()

num_tests = 0
num_passed = 0

if args.t:
    print(args.t)
    if check(args.t):
        sys.exit(0)
    else:
        sys.exit(1)

if args.student:
    for test in find_tests("tests/student"):
        print(test.split("/")[-1])
        num_tests += 1
        if check(test):
            num_passed += 1

else:
    for test in find_tests("tests/pub"):
        print(test.split("/")[-1])
        num_tests += 1
        if check(test):
            num_passed += 1


print("---------------")
print("===> " + str(num_passed) + "/" + str(num_tests))

if num_tests == num_passed:
    sys.exit(0)
else:
    sys.exit(1)
