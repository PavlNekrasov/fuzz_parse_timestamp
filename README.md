# Fuzzing parse_timestamp

## Подготовка окружения
1. Собираем образ
```
docker build --tag=fuzz_parse_timestamp_image .
```
2. Запускаем контейнер
```
docker run -it --name=fuzz_parse_timestamp -v "$(pwd)/artifacts:/home/fuzz/artifacts" --network=host fuzz_parse_timestamp_image
```
3. Собираем systemd в контейнере с включёнными санитайзерами (asan, ubsan), а также собираем фаззер:
```
cd /home/fuzz && ./artifacts/build.sh
```

## Запуск фаззера
```
cd /home/fuzz
```
```
./fuzz corpus
```
