#!/usr/bin/env python3

#
# Helper script written in python. Provide some ultilities for CI checks and workflow
# Usage: ./scripts/helper.py --help
#

import argparse
import os
import subprocess

from typing import List


def print_usage():
    print('Run with --help to get more info')


def get_working_directories(file_list: str) -> List[str]:
    files = file_list.split(' ')

    # Get list of working directories: file_path can be a file or a directory
    directories = []
    for fpath in files:
        if os.path.isfile(fpath) and fpath.endswith('.tf'):
            dir_path = fpath.rsplit('/', 1)[0]
            directories.append(dir_path)
            
            # Include also /tests sub-direcotory if we are changing the TF files in root module
            tests_dir = [x[0] for x in os.walk(dir_path) if '/tests/' in x[0]]
            directories.extend(tests_dir)

        elif os.path.isdir(fpath):
            directories.append(fpath)

    # Exclude ".terraform" folder
    directories = list(set([d for d in directories if '.terraform' not in d]))
    directories.sort()

    return directories


def run_terraform_fmt(file_list: str, is_check: bool):
    directories = get_working_directories(file_list)

    is_failure = False
    for directory in directories:
        terraform_fmt_cmd = 'terraform fmt -check -no-color %s' % directory if is_check else 'terraform fmt -no-color %s' % directory
        result = subprocess.run([terraform_fmt_cmd], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                timeout=30, shell=True, universal_newlines=True)

        print('Running %s' % terraform_fmt_cmd)

        if result.returncode != 0:
            print('Terraform Format error : terraform fmt %s %s' % (result.stdout, result.stderr))
            is_failure = True

    if is_failure:
        exit(1)


def run_terraform_validate(file_list: str):
    directories = get_working_directories(file_list)

    # Filter only directories that contains '/tests' in its path
    directories = [d for d in directories if "/tests" in d]

    is_failure = False
    for directory in directories:
        terraform_validate_cmd = 'terraform init && terraform validate -no-color'
        result = subprocess.run([terraform_validate_cmd], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                timeout=30, shell=True, universal_newlines=True, cwd=directory)

        print('Running %s %s' % (terraform_validate_cmd, directory))

        if result.returncode != 0:
            print('Terraform Validate error on directory : %s \n%s %s' % (directory, result.stdout, result.stderr))
            is_failure = True

    if is_failure:
        exit(1)


def run_terraform_plan(file_list: str):
    directories = get_working_directories(file_list)

    # Filter only directories that contains '/tests' in its path
    directories = [d for d in directories if "/tests" in d]

    is_failure = False
    for directory in directories:
        terraform_plan_cmd = 'terraform init && terraform plan -no-color'
        result = subprocess.run([terraform_plan_cmd], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                timeout=30, shell=True, universal_newlines=True, cwd=directory)

        print('Running %s %s' % (terraform_plan_cmd, directory))

        if result.returncode != 0:
            print('Terraform Plan error on directory : %s \n%s %s' % (directory, result.stdout, result.stderr))
            is_failure = True

    if is_failure:
        exit(1)


def parse_args():
    parser = argparse.ArgumentParser(description='Helper script')

    subparsers = parser.add_subparsers(dest='func')

    run_terraform_fmt_parser = subparsers.add_parser(
        'run-terraform-fmt', help='Run terraform fmt on list of working directories')
    run_terraform_fmt_parser.add_argument(
        '-f', '--file_list', help='List of changed files separated by space')
    run_terraform_fmt_parser.add_argument(
        '-c', '--check', help='Whether to run terraform format check instead', action="store_true")

    run_terraform_validate_parser = subparsers.add_parser(
        'run-terraform-validate', help='Run terraform validate on list of working directories')
    run_terraform_validate_parser.add_argument(
        '-f', '--file_list', help='List of changed files separated by space')

    run_terraform_plan_parser = subparsers.add_parser(
        'run-terraform-plan', help='Run terraform plan on list of working directories')
    run_terraform_plan_parser.add_argument(
        '-f', '--file_list', help='List of changed files separated by space')

    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()

    if args.func == 'run-terraform-fmt':
        run_terraform_fmt(args.file_list, args.check)
    elif args.func == 'run-terraform-validate':
        run_terraform_validate(args.file_list)
    elif args.func == 'run-terraform-plan':
        run_terraform_plan(args.file_list)
    else:
        print_usage()
