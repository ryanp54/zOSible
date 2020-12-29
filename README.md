# Easing entry to mainframe programming

zOSible provides command line interface that uses a set of Ansible playbooks to make getting started with mainframe JCL and REXX programming as simple as possible.

## Getting Started

Version 1.2.1 of the ibm_zos_core Ansible collection is used, which has the following requirements for the mainframe being accessed:

- IBM Open Enterprise Python for z/OS: 3.8.2 or later
- IBM Z Open Automation Utilities 1.0.3 PTF UI70435
- z/OS V2R3 or later
- The z/OS® shell

zOSible runs in a Docker container to allow for easy setup and to avoid system compatability issues. The Docker image should be built from the included Docker file.
```bash
docker build -t zosible:latest ./
```
When creating the container specify it should be interactive and allocated a pseudo-TTY by using the `-i` and `-t` options. You'll also likely want to specify a volume or bind mount to allow access to a local directory with the `-v` or `--mount` option.
```bash
docker create -it -v "C:/example/dir":/mnt --name zosible zosible:latest
```
The interactive option should also be included when starting the container.
```bash
docker start -i zosible
```

## Usage

Before running any commands `zosible setup` needs to be run to set up the connection details. This also sets up SSH keys to use for authentication. The passphrase protecting the key file will be the same as the password used to connect to the mainframe. If you do not wish the key file to be passphrase protected, include the `--no-pass` or '`-p` option when running the command.

The main feature of zOSible is the submit command:
<pre>zosible submit <i>local_file_name</i> <i>[data_set_name]</i></pre>
This uploads the local file to the mainframe and either submits it as a job for execution, or if the first line contains the appropriate comment indicating it is REXX, executes it. It then displays the resulting output. If the data set name is not provided, a temporary data set will be created. This and any command that accepts a data set name will also allow a PDS member name to be included.

A few other commands are available to provide basic data set operations. The `-h` option can be used with any command view the syntax and options available.

- To upload a file as a data set use `zosible create`
- To download a data set use `zosible fetch`
- To delete a data set use `zosible delete`

Lastly, basic data set listing functionality is available with:
<pre>zosible list <i>query</i></pre>
The query can include one wildcard in place of one of the qualifiers (except for the high level qualifier). In this case it will list all matching data set names found. If no wildcard is included, it will list all PDS members of the data set named in the query.
