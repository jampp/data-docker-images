==========
Change Log
==========

All notable changes to this project will be documented here.

Sort subsections like so: Added, Bugfixes, Improvements, Technical tasks.
Group anything an end user shouldn't care deeply about into technical
tasks, even if they're technically bugs. Only include as "bugfixes"
bugs with user-visible outcomes.

When major components get significant changes worthy of mention, they
can be described in a Major section.

More information can be found HERE:


v2.4.0 - 2022-02-18
===================

Changed
-------

* Update Trino version to 370.
* Disabled mysql in airflow image.


v2.3.0 - Unreleased
===================

Changed
-------

* Update Trino version to 367.


=======
v2.2.0 - 2021-11-23
===================

Added
-----


* add compatibility and Upgraded Spark to version 3.1.2


v2.1.1 - 2021-11-16
===================

Added
-----

* Access to Hive through Spark 


v2.1.0 - 2021-11-11
===================

Added
-----

* Upgrade migratron to 2.2.0
* Change Spark image to enable Hive integration.
* Use Livy 0.8.0 SNAPSHOT to enable the use of sessions for Spark 3.
