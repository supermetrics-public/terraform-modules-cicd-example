#!/usr/bin/env python

import argparse
import subprocess


def print_usage():
    print('Run with --help to get more info')


def get_working_directories(file_list: str):
    files = file_list.split(' ')

    directories = list(set([f.rsplit('/', 1)[0] for f in files if f.endswith('.tf')]))
    directories.sort()

    print(' '.join(directories))


def run_terraform_fmt(file_list: str):
    files = file_list.split(' ')

    directories = list(set([f.rsplit('/', 1)[0] for f in files]))
    directories.sort()

    for directory in directories:
        result = subprocess.run(['terraform fmt -check -no-color %s' % directory], capture_output=True, timeout=30, shell=True, universal_newlines=True)
        if result.returncode != 0:
            print('Terraform Format error at %s' % result.stdout)
            exit(result.returncode)


def parse_args():
    parser = argparse.ArgumentParser(description='Helper script')

    subparsers = parser.add_subparsers(dest='func')

    get_working_directories_parser = subparsers.add_parser('get-working-directories', help='Convert list of files to working directories')
    get_working_directories_parser.add_argument('-f', '--file_list', help='List of changed files separated by space')

    run_terraform_fmt_parser = subparsers.add_parser('run-terraform-fmt', help='Run terraform fmt check on list of working directories')
    run_terraform_fmt_parser.add_argument('-f', '--file_list', help='List of changed files separated by space')

    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()

    if args.func == 'get-working-directories':
        get_working_directories(args.file_list)
    elif args.func == 'run-terraform-fmt':
        run_terraform_fmt(args.file_list)
    else:
        print_usage()

    exit(0)
