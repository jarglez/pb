FROM python:3.8-alpine

WORKDIR /pb

RUN apk add --no-cache --virtual .build-deps git && \
    apk add --no-cache --virtual .runtime-deps uwsgi uwsgi-python3

EXPOSE 8080
ENV CDN_PREFIX=//d34zelngniy2d8.cloudfront.net
ENV VIRTUAL_PORT 8080

COPY . .
RUN pip install -r /pb/requirements.txt && \
    pip install /pb && \
    apk del .build-deps

CMD ["uwsgi", "--ini", "pb.ini"]
