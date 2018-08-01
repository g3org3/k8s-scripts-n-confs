#!/bin/bash
TOKEN=`python -c 'import random; print "%0x.%0x" % (random.SystemRandom().getrandbits(3*8), random.SystemRandom().getrandbits(8*8))'`
sed -i.bak "s/^TOKEN=.*/TOKEN=${TOKEN}/" ./master.sh
sed -i.bak "s/^TOKEN=.*/TOKEN=${TOKEN}/" ./node.sh
rm *.bak