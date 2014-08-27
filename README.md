# sshknownhosts


## Installation

Copy `sshknownhosts` to `$ANSIBLE_LIBRARY` on the management host.

        install -m 444 sshknownhosts $ANSIBLE_LIBRARY/sshknownhosts


## Usage

        sshknownhosts
                host= host1.domain.com
                dest= /path/to/ssh_known_hosts (default: /etc/ssh/ssh_known_hosts)
                enctype= rsa|dsa|ecdsa (default: rsa)
                keyscan= /path/to/ssh-keyscan (default: use ssh-keyscan in $PATH)
                port= portnumber (default: 22)
		aliases= alias1[,...] (default: no aliases)
                state= present|absent (default: present)

## Playbook

        - name: Add localhost to ssh_known_hosts file
          action: sshknownhosts host=localhost state=present port=2222

        - name: Add several hosts to ssh_known_hosts file
          action: sshknownhosts host={{ item }} state=present
          with_items:
            - host1.example.com
            - host2.example.com
            - host3.example.com



## Security

If an ssh_known_hosts file is constructed using ssh-keyscan without
verifying the keys, users will be vulnerable to man in the middle
attacks.  On the other hand, if the security model allows such a risk,
ssh-keyscan can help in the detection of tampered keyfiles or man in
the middle attacks which have begun after the ssh_known_hosts file was
created.

(taken from the ssh-keyscan man page)


## Possible Future Enhancements

- key: supplying the host key from a string or file instead of looking
  it up with the ssh-keyscan program.
- more options from the ssh-keyscan program such as IPv4/IPv6 addresses.
- allow multiple key types (rsa and dsa together, for example)

Feedback on these and other options would be appreciated.


## Notes

* A module I wrote for my own use that others might find useful, so I
  added some docs and put it up on github.
* This is my first python program, so I appreciate some feedback (and
  my first public ansible module)
* Tested on Debian flavours (Mint 14 and up) and OpenBSD 5.2 and up.
* Contact me at http://www.bfmartin.ca/contact/

## License

This is released under the BSD license.  See the LICENSE file for a
full statement.
