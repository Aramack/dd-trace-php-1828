This project is intended as an example for https://github.com/DataDog/dd-trace-php/issues/1828.

# Steps to reproduce
## Build
```
sudo docker build --tag image-dd-trace-php-1828 .
```

## Run NGING/PHP-FPM Server
```
sudo docker run --rm --name dd-trace-php-1828 --publish 8000:80 image-dd-trace-php-1828
```

## Run the test script
```
curl "https://127.0.0.1:8000"
```

## Expected output from step 2
```
[09-Dec-2022 16:55:26] NOTICE: fpm is running, pid 9
[09-Dec-2022 16:55:26] NOTICE: ready to handle connections
[09-Dec-2022 16:55:31] WARNING: [pool www] child 11 exited on signal 11 (SIGSEGV - core dumped) after 4.692369 seconds from start
[09-Dec-2022 16:55:31] NOTICE: [pool www] child 16 started
```

# Other notes
## Shut down container because I can't figure out how to get the run command to take keyboar interrupts
```
sudo docker ps | grep dd-trace-php-1828 | awk -F ' ' '{print $1}' | xargs -I % sudo docker stop %
```

## Interactive Shell
```
sudo docker  run --interactive --tty  image-dd-trace-php-1828 /bin/bash
```
