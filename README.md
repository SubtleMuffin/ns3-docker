# ns3-docker

## Why?

The benefits of developing ns3 in Docker are,

1. Cross platform and hustle-free experience -- no need to install dependencies and worry about consistencies, all taken care of.
2. Clean -- users do not have to worry about messing with their own directories.
3. Deployable remotely -- let a powerful server run these images, and VS Code is able to open a remote SSH session to the server's docker engine, c.f. [here](https://code.visualstudio.com/docs/containers/ssh).
4. Sharing and collaborations made easy -- all the user have to do is share the container, which include all code changes and corresponding binaries. Therefore, the problems they encounter will be 100% reproducible.
5. New M1 Apple Silicon -- Docker has bring native M1 support, meaning one can enjoy the enormous computational speedup on the latest greatest Mac. If the `ns-3` drop the support for M1 Mac (which is hardly the case), one can continue their work on Docker.

But it has some downsides as well,

1. Users are required to have some basic knowledge of Docker.
2. ~~Performance maybe sacrificed -- but it is hard to tell Linux docker execution speed vs. macOS native binaries speed.~~


`macOS` with `clang++ v12.0.0`
```shell
paul@mbp ~/D/ns-3-dev (master)> time ./waf --run scratch/wifi-spatial-reuse
Waf: Entering directory `/Users/paul/Desktop/ns-3-dev/build'
Waf: Leaving directory `/Users/paul/Desktop/ns-3-dev/build'
Build commands will be stored in build/compile_commands.json
'build' finished successfully (0.427s)
Throughput for BSS 1: 6.6732 Mbit/s
Throughput for BSS 2: 6.6768 Mbit/s

________________________________________________________
Executed in   42.43 secs   fish           external
   usr time   37.72 secs  118.00 micros   37.72 secs
   sys time    1.94 secs  636.00 micros    1.94 secs
```

`debian 10` with `g++ v8.3` [see log here](https://hub.docker.com/repository/docker/subtlemuffin/ns3-docker/builds/53cf4cf3-c6a6-4458-ba0a-b533ebfc26a0)
```shell
root@ae3feed8062d:/ns-3-dev# time ./waf --run scratch/wifi-spatial-reuse
Waf: Entering directory `/ns-3-dev/build'
Waf: Leaving directory `/ns-3-dev/build'
Build commands will be stored in build/compile_commands.json
'build' finished successfully (0.747s)
Throughput for BSS 1: 6.6732 Mbit/s
Throughput for BSS 2: 6.6768 Mbit/s

real	0m29.323s
user	0m29.236s
sys	0m0.173s
```


## How?

This docker image is meant for developing ns3 on a docker image. A suggested workflow could be

1. Pull this docker image via
```shell
docker pull subtlemuffin/ns3-docker:latest
```

2. Spawn a container (and keep it running in the background)
```
docker run -itd --name ns3 subtlemuffin/ns3-docker:latest
```

3. Test if everything is OK
```shell
docker exec -it ns3 ./waf --run scratch/scratch-simulator
```


Tips & Tricks

* Start a container
```shell
docker start ns3
```

* Spin up a container and attach to it
```shell
docker run -it --name ns3 subtlemuffin/ns3-docker:latest
```

This example runs a container named `ns3` using the `subtlemuffin/ns3:latest` image. The `-it` instructs Docker to allocate a pseudo-TTY connected to the container’s stdin; creating an interactive bash shell in the container.

* Attach to a running container to open a new terminal session
```shell
docker attach ns3
```


* VS Code and Docker Development

Firstly, please make sure that the ns3 docker container is running via
```shell
docker ps
```

An example output could be
```
CONTAINER ID   IMAGE                     COMMAND       CREATED         STATUS        PORTS     NAMES
a0a5efceab78   subtlemuffin/ns3:latest   "/bin/bash"   2 seconds ago   Up 1 second             ns3
```

Please also make sure that the following extensions are installed

* [Remote-Contianers by Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
* [C++ by Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)


These can be installed via `VS Code Quick Open` (<key>Ctrl</key>+<key>P</key>) and type in
```
ext install ms-vscode-remote.remote-containers
```
and
```
ext install ms-vscode.cpptools
```

Once all the above dependencies are satisfied (i.e., `ns3` container is running and extensions are all installed), please open a new VS Code window, and on the bottom left corner, click and select `Remote-Containers: Attach to Running Container`. You are now able to enjoy the benefits of developing in Docker. Intellisense and debugging should be fine.

