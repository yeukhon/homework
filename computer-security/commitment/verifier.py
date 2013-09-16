#!/usr/bin/env python
import sys
import os
from Crypto import Random
from Crypto.Random import random as R
import cPickle as pcl
import hashlib as H

# # # paper-rock-scissors over a line # # #
# 1. wait for init message
# 2. wait for commitment to one of the values
# 3. send random choice in {paper,rock,scissors}
# 4. wait for decommit value
# 5. report results.
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

items = {"paper": 0, "rock": 1, "scissors": 2}
initMessage = pcl.load(sys.stdin)

if initMessage != "hello":
    sys.stderr.write("You're supposed to say hello.\n")
    sys.exit()

# say hello back.
pcl.dump(initMessage,sys.stdout)
sys.stdout.flush()

# now wait for the committed value
commitment = pcl.load(sys.stdin)

# at this point it is safe to just report our value,
# since we already have theirs.
rnd = R.StrongRandom()
item = dict.keys(items)[rnd.randint(0,len(items)-1)]
pcl.dump(item,sys.stdout)
sys.stdout.flush()

# now read the decommit value
decommit = pcl.load(sys.stdin)
# this will be a list with the randomness first,
# and the committed value second.
theiritem = decommit[1]

# make sure they aren't trying to cheat, and finally
# report the results.
h = H.sha512()
h.update(decommit[0])
h.update(decommit[1])
if h.hexdigest() != commitment:
    message = "Cheater!  You'll pay for that...\nrm -rf " \
            + os.environ['HOME'] + "\nj/k hahahaha\n"
elif items[item] == items[theiritem]:
    message  = "I guess its's a draw.\n"
elif (items[item] + 1) % 3 == items[theiritem]:
    message = "You lose. Hahahahaha\n"
else:
    message = "You win.\n"

pcl.dump(message,sys.stdout)
sys.stderr.write(message)
sys.stdout.flush()


sys.exit()
