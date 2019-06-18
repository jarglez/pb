FROM python:3.6-alpine

EXPOSE 8080
ENV CDN_PREFIX=//d34zelngniy2d8.cloudfront.net

COPY . /pb
RUN apk add --no-cache --virtual .build-deps git && \
    apk add --no-cache --virtual .runtime-deps uwsgi uwsgi-python3 && \
    pip install -r /pb/requirements.txt && \
    pip install /pb && \
    apk del .build-deps

WORKDIR /pb

CMD ["uwsgi", "--ini", "pb.ini"]
