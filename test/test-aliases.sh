#!/bin/bash
#
# this tests some alias features of the sshknownhosts module for ansible
#
# test 1:
# a. this bash script will create a dummy ssh_known_hosts file in the
#    currect directory and add localhost and 127.0.0.1 entries. then it
#    saves a copy
# b. next it adds aliases for each of the entries
# c. then, it removes the aliases that were added in the previous
#    step. it compares the result with the saved copy from a few steps
#    ago.
#
# test 2:
# a. using the same known hosts file from the previous step, it tries
#    to remove an entry using an alias. this should fail and the file
#    comparison should result in a match.

TEST_KH_FILE=testknownhosts
INVENTORY_FILE=inventory

# args:
# all               which hosts from the invetory file to use
# -i inventory file the inventory file. it is created below
# -M ..             location of the module to test
# -c local          connection type local
# -o                one-line output
# -m sshknownhosts  name of the module to test
# -a                module args follow
ANSIBLE_ARGS="all -i ${INVENTORY_FILE} -M .. -c local -o -m sshknownhosts -a"

echo localhost > ${INVENTORY_FILE}

# remove file, if it exists
rm -f ${TEST_KH_FILE}

### Test 1

# add a couple of entries
ansible ${ANSIBLE_ARGS} "host=localhost dest=${TEST_KH_FILE}"
ansible ${ANSIBLE_ARGS} "host=127.0.0.1 dest=${TEST_KH_FILE}"
# cat ${TEST_KH_FILE}

# save a copy of this file for later comparison
cp ${TEST_KH_FILE} ${TEST_KH_FILE}-save

# now add aliases
ansible ${ANSIBLE_ARGS} "host=localhost dest=${TEST_KH_FILE} aliases=gitserver"
ansible ${ANSIBLE_ARGS} "host=127.0.0.1 dest=${TEST_KH_FILE} aliases=svnserver"
# cat ${TEST_KH_FILE}

# now remove aliases
ansible ${ANSIBLE_ARGS} "host=localhost dest=${TEST_KH_FILE}"
ansible ${ANSIBLE_ARGS} "host=127.0.0.1 dest=${TEST_KH_FILE}"
# cat ${TEST_KH_FILE}

# there should be no difference from the save file
diff ${TEST_KH_FILE} ${TEST_KH_FILE}-save
if [ $? -ne 0 ]; then echo test failed 1; fi

### Test 2

# try to remove an entry using an alias. this should not work
ansible ${ANSIBLE_ARGS} "host=gitserver dest=${TEST_KH_FILE} state=absent"
diff ${TEST_KH_FILE} ${TEST_KH_FILE}-save
if [ $? -ne 0 ]; then echo test failed 2; fi

### done

# cleanup
rm -f ${TEST_KH_FILE} ${TEST_KH_FILE}-save ${INVENTORY_FILE}
