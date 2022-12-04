FROM alpine

# Default backup interval is once a day
ENV CRON_EXPRESSION="0 0 * * *" 

VOLUME [ "/data" ]


RUN apk add --no-cache python3 py3-pip bash && pip install decode-config

COPY backup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/backup.sh && mkdir /data

COPY setupcron.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setupcron.sh


ENTRYPOINT [ "./usr/local/bin/setupcron.sh" ]