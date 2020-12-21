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
2. Performance maybe sacrificed -- but it is hard to tell Linux docker execution speed vs. macOS native binaries speed.

## How?

This docker image is meant for developing ns3 on a docker image. A suggested workflow could be

1. Pull this docker image via

```shell
docker pull subtlemuffin/ns3:latest
```

2. Spawn a container (and keep it running in the background)
```
docker run -td --name ns3 subtlemuffin/ns3:latest
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
docker run -it --name ns3 subtlemuffin/ns3:latest
```

This example runs a container named `ns3` using the `subtlemuffin/ns3:latest` image. The `-it` instructs Docker to allocate a pseudo-TTY connected to the container’s stdin; creating an interactive bash shell in the container.

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

* [Docker by Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
* [C++ by Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)


These can be installed via `VS Code Quick Open` (<key>Ctrl</key>+<key>P</key>) and type in
```
ext install ms-azuretools.vscode-docker
```
and
```
ext install ms-vscode.cpptools
```

Once all the above dependencies are satisfied (i.e., `ns3` container is running and extensions are all installed), please open a new VS Code window, and on the bottom left corner, click and select `Remote-Containers: Attach to Running Container`. You are now able to enjoy the benefits of developing in Docker. Intellisense and debugging should be fine.

