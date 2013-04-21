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


## Security

If an ssh_known_hosts file is constructed using ssh-keyscan without
verifying the keys, users will be vulnerable to man in the middle
attacks.  On the other hand, if the security model allows such a risk,
ssh-keyscan can help in the detection of tampered keyfiles or man in
the middle attacks which have begun after the ssh_known_hosts file was
created.

(taken from the ssk-keyscan man page)


## Future Enhancements

Here's what I'm considering adding in the future:

- aliases: adding aliases for hosts.  They end up in the known hosts
  file like this: host1,alias1,alias2 sshkey
- key: supplying the host key from a string or file instead of looking
  it up with the ssh-keyscan program.
- ssh information: use configuration items for ssh used by the
  ssh-keyscan program such as port number, or IPv4/IPv6 addresses.
- allow multiple key types (rsa and dsa together, for example)

Feedback on these and other options would be appreciated.


## Notes

* A module I wrote for my own use that others might find useful, so I
  added some docs and put it up on github.
* This is my first python program, so I appreciate some feedback
* Tested on Debian flavours (Mint 14, Debian Unstable and XUbuntu
  12.10) and OpenBSD.
* Contact me at https://www.bfmartin.ca/contact/
