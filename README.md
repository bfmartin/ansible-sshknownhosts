# sshknownhosts


## Installation

Copy `sshknownhosts` to `$ANSIBLE_LIBRARY` on the management host.

	install -m 444 sshknownhosts $ANSIBLE_LIBRARY/sshknownhosts

## Usage

	sshknownhosts
		host= host1.domain.com
		state= present|absent (default: present)


## Playbook

	- name: Add hosts to ssh_known_hosts file
	  action: sshknownhosts host=localhost state=present

## Future Enhancements

Here's what I'm considering adding in the future:

- aliases: adding aliases for hosts.  They end up in the known hosts
  file like this: host1,alias1,alias2 sshkey
- key: supplying the host key from a string or file instead of looking
  it up with the ssh-keyscan program.

Feedback on these and other options would be appreciated.

## Notes

* A module I wrote for my own use that others might find useful, so I
  added some docs and put it up on github.
* My first python program, so I appreciate some feedback
* Tested on Debian flavours (Mint 14, Debian Unstable and XUbuntu
  12.10) and OpenBSD.
* Contact me at https://www.bfmartin.ca/contact/
