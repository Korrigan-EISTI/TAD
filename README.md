# Using GLPI database on your computer

<br>

## How to deploy GLPI database on your computer

First download an Oracle Database and connect to _system_ to run :

1) `user.sql`

<br>

Then connect to _glpiAdmin_ with the password _glpiAdmin_

<br>

Finally run the sql scripts in the following order :

2) `cluster.sql`
3) `init.sql`
4) `index.sql`
5) `view.sql`
6) `sequence.sql`
7) `procedure.sql`
8) `trigger.sql`

<br>

## How to cancel the deployment of GLPI database on your computer

Simply connect to _system_ and run `cancel.sql`