#!/usr/bin/env python

import sys
from subprocess import *
import cPickle as pcl

import uuid
import random
import hashlib

p1 = Popen(["./verifier.py"], stdin=PIPE, stdout=PIPE, close_fds=True)

# start the conversation with a "hello" message
hellomesg = "hello"
pcl.dump(hellomesg, p1.stdin)
p1.stdin.flush()

# confirm the hello message:
hellomesg = pcl.load(p1.stdout)
if hellomesg != "hello":
    sys.stderr.write("You're supposed to say hello.\n")
    sys.exit()

# TODO: make your guess, make a commitment to it, and
# then send the committed value to the verifier.  Your
# guess needs to be one of "rock","paper","scissors"

# send committed value:
guess = random.choice(['rock', 'paper', 'scissors'])
r = str(uuid.uuid1())
commitment = hashlib.sha512(r+guess).hexdigest()
pcl.dump(commitment,p1.stdin)
p1.stdin.flush()

# now we get the value from the other party:
theirs = pcl.load(p1.stdout)

# and now that we have theirs, it is safe to decommit.
# TODO: reveal the value by sending a two-item list
# consisting of the randomness for the commitment, and
# the value that you committed to.

decommit = [r, guess]
pcl.dump(decommit, p1.stdin)
p1.stdin.flush()

# That's about all there is to it.
p1.stdin.close()

sys.exit()
