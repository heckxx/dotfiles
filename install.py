#!/usr/bin/env python
# TODO: implement backup option

import argparse, glob
from glob import glob
from subprocess import call

class Defaults:
    mode = 'desktop'
    stow_mode = 'stow'
    verbosity = 1
    backup = None
    simulate = False

VERSION = '1'

def main():
    # take care of arguments
    parser = argparse.ArgumentParser(prog='dotfiles')
    parser.add_argument('--version', action='version', version='%(prog)s v'+VERSION)
    stow_mode_group = parser.add_mutually_exclusive_group()
    stow_mode_group.add_argument('--stow', action='store_const', const='stow', dest='stow_mode', default=Defaults.stow_mode,
            help='stow dotfiles')
    stow_mode_group.add_argument('--delete', action='store_const', const='delete', dest='stow_mode', default=Defaults.stow_mode,
            help='delete dotfiles')
    stow_mode_group.add_argument('--restow', action='store_const', const='restow', dest='stow_mode', default=Defaults.stow_mode,
            help='restow dotfiles')
    mode_group = parser.add_mutually_exclusive_group(required=True)
    mode_group.add_argument('--desktop', action='store_const', const='desktop', dest='mode', default=Defaults.mode,
            help='install desktop dotfiles')
    mode_group.add_argument('--laptop', action='store_const', const='laptop', dest='mode', default=Defaults.mode,
            help='install laptop dotfiles')
    verbose_group = parser.add_mutually_exclusive_group()
    verbose_group.add_argument('-v', '--verbosity', type=int, action='store', default=Defaults.verbosity, metavar='N',
            help='change the verbosity of stow (0-3)')
    verbose_group.add_argument('-q', '--quiet', action='store_const', const=0, default=Defaults.verbosity,
            help='quiet mode, same as -v 0')
    parser.add_argument('-d', '--dry-run', '--simulate', action='store_const', const=True, dest='simulate', default=Defaults.simulate,
            help='perform dry run (don\'t change filesystem)')
    parser.add_argument('-b', '--backup', action='store', dest='backup', default=Defaults.backup, metavar="FOLDER",
            help='backup existing dotfiles to FOLDER')
    args = parser.parse_args()
    mode = args.mode
    verbosity = args.verbosity
    backup = args.backup
    simulate = args.simulate
    stow_mode = args.stow_mode

    laptop_apps = set(glob('laptop_*/'))
    desktop_apps = set(glob('desktop_*/'))
    mode_apps = set(glob('*/'))
    if mode is 'laptop':
        mode_apps -= set(desktop_apps)
    elif mode is 'desktop':
        mode_apps -= set(laptop_apps)
    else:
        print("Mode not either laptop or desktop???? Bailing out")
        return
    for dotfile in mode_apps:
        if simulate:
            call(['echo','stow', '-v', str(verbosity), '--'+stow_mode, '--simulate', dotfile])
            call(['stow', '-v', str(verbosity), '--'+stow_mode, '--simulate', dotfile])
        else:
            call(['stow', '-v', str(verbosity), '--'+stow_mode, dotfile])



if __name__ == '__main__':
    main()
