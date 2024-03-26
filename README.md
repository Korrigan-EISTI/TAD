# Using GLPI database on your computer

<br>

## How to deploy GLPI database on your computer

After setting up an Oracle Database on your computer, you first need to connect to _system_ and run :

1) `user.sql`

<br>

Then connect to _glpiAdmin_cergy_ with the password _cergy_

<br>

Then run the sql scripts in the following order :

1) `cluster.sql`
2) `init.sql`
3) `index.sql`
4) `sequence.sql`
5) `procedure.sql`
6) `trigger.sql`
7) `Cergy/views_cergy.sql`
8) `Cergy/trigger_cergy.sql`

<br>

<br>

Then connect to _glpiAdmin_pau_ with the password _pau_

<br>

Then run the sql scripts in the following order :

1) `cluster.sql`
2) `init.sql`
3) `index.sql`
4) `sequence.sql`
5) `procedure.sql`
6) `trigger.sql`
7) `Pau/views_pau.sql`
8) `Pau/trigger_pau.sql`

<br>

Finally connect to _glpiAdmin_ with the password _glpiAdmin_ :

1) `view.sql`

<br>

## How to cancel the deployment of GLPI database on your computer

Simply connect to _glpiAdmin_pau_ with the password _pau_ and run `Pau/cancel_pau.sql` then to _glpiAdmin_cergy_ with the password _cergy_ and run `Cergy/cancel_cergy.sql`

Finally connect to _glpiAdmin_ with the password _glpiAdmin_ and run `cancel.sql`

## Temp (on school laptop):

@"C:\Users\CYTech Student\TAD\user.sql"

CONNECT glpiAdmin/glpiAdmin

@"C:\Users\CYTech Student\TAD\sequence.sql"
@"C:\Users\CYTech Student\TAD\cluster.sql"
@"C:\Users\CYTech Student\TAD\init.sql"
@"C:\Users\CYTech Student\TAD\index.sql"
@"C:\Users\CYTech Student\TAD\procedure.sql"
@"C:\Users\CYTech Student\TAD\role.sql"
@"C:\Users\CYTech Student\TAD\trigger.sql"
@"C:\Users\CYTech Student\TAD\view.sql"

@"C:\Users\CYTech Student\TAD\Cergy\views_cergy.sql"
@"C:\Users\CYTech Student\TAD\Cergy\trigger_cergy.sql"
@"C:\Users\CYTech Student\TAD\Pau\views_pau.sql"
@"C:\Users\CYTech Student\TAD\Pau\trigger_pau.sql"

alter session set "_ORACLE_SCRIPT"=true;

@"C:\Users\CYTech Student\TAD\data_users.sql"
@"C:\Users\CYTech Student\TAD\data_entities.sql"

CONNECT Berg_Xanthus/KWK34CES9KU

@"C:\Users\CYTech Student\TAD\data_tickets.sql"