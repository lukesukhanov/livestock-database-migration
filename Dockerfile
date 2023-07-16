FROM liquibase/liquibase:4.23-alpine
WORKDIR /opt/liquibase
COPY . $WORKDIR
ENTRYPOINT ["liquibase", "update"]