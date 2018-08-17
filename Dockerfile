FROM ubuntu:18.04

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive

RUN echo -e "slapd/root_password password password" |debconf-set-selections && \
    echo -e "slapd/root_password_again password password" |debconf-set-selections && \
    echo -e "slapd/internal/adminpw password password" |debconf-set-selections && \
    echo -e "slapd/internal/generated_adminpw password password" |debconf-set-selections && \
    echo -e "slapd/password2 password password" |debconf-set-selections && \
    echo -e "slapd/password1 password password" |debconf-set-selections && \
    echo -e "slapd/domain string dev.local" |debconf-set-selections && \
    echo -e "shared/organization string testorg" |debconf-set-selections && \
    echo -e "slapd/backend string HDB" |debconf-set-selections && \
    echo -e "slapd/purge_database boolean true" |debconf-set-selections && \
    echo -e "slapd/move_old_database boolean true" |debconf-set-selections && \
    echo -e "slapd/allow_ldap_v2 boolean false" |debconf-set-selections && \
    echo -e "slapd/no_configuration boolean false" |debconf-set-selections && \
    apt-get install -y ldap-utils slapd nano && \
    service slapd start && \
    ldapsearch -x -LLL -h 127.0.0.1 -D "cn=admin,dc=dev,dc=local" -w "password" -b "dc=dev,dc=local"

CMD service slapd start
