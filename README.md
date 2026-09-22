# Presentation (EN)

The project-Archimedes itself is my PoC (prove of concept) and architecture of my services and computing nodes.

Here in this repo you, the reader, will find descriptions, technical choices, hardware/software trade-offs and work around that'll make this a very unique and idiosyncratic repo, besides the technologies itself. It will be clear along the way to an interest reader, but regardless the fact that I'll pass through many aspects of all the tech roles that you can possibly imagine, currently I'm focusing in the Dev Ops mastery.

It is quite important to expose the core principles of this project, those who are - _and will_ - be changed along the way as the repo needs grows:

- **self-hosted first:** Up until this day I strongly believe that to have a strong knowledge of a tool or skill first you have to dig down to it's core and supporting axioms, so regardless physical and financial limitations, I will always prefer to develop the structure of the whole within my own equipment. Every service or technical choices whose won't follow that will be done with the proper trade-off and knowledge driven explanation.

- **agnostic of hardware:** Besides the impression of a contradiction, respecting my limitations and my machines, the project and architecture will always be built towards the largest amount of hardware _and platforms_, which includes cloud environments, old machines, non-purposed hardware, virtual and bare metal. The only explicit limitations whose I compromise with are my knowledge and the atomic reduction and the software and services that I produce.

- **Driven to scale, limited by time:** Regardless of my personal will to spend 16h/day working in here, I solely compromise myself as the only maintainer of this project, so create an idempotent non-needed-supervised environment is both skill and necessity.

- **Build, brake, fix, learn, repeat:** Don't mix your expectations, this is a learning environment! I'll do anything in my power to simulate a real, formal, constrained ambient to achieve it's best state, but will won't be able to do always, but that is the exactly state which I pursuit - learn fast and don't mess in real production.

- **Craft it first, abstract latter:** This one is particulary important for head hunters and people who might see or clone this repo. This is the completion of all princibles above. I'll not allow myself to use abstract tools such as composes, cloud computing, frameworks, CI/CD pipelines and such before I see the clear necessity to use 'em, that doesn't mean I'm a senior in what I use, but at the very bottom I know tge trade-offs of what I'm doing.

## Current architecture

At the current state, I posses three working machines, each with it's specif limitation. You can check the the [detailed spec file in here](./inventory/cluster.yaml), which presents an yaml file describing each node of the cluster. 

Here's a quick diagram of the current/planed workflow, which may of may not be currently available:

```ASCII

\__________________________________________________________________________________________    
\    
\        user - web
\             |
\      personal domain -- \
\             |            \
\         HTTP tunnel -- cloudflare ---------------------------------------
\             |                                                          |
\  Portfolio environment -- Documentation -- MkDocks webpages            |
\      /      |  \                                                       |
\     /       |   \                                                      |
\    /        |    Public performance dashboard -- Grafana ¹             |
\   /         |                                                        Nginx
\   |  Self-hosted services ²                                        Dedicated  
\   |                                                              load-balancer  
\   |                                                                    |
\   ------- Cluster -----------------------------------------------------|
\           /  |  \
\          /   |   \
\     Ansible  |    \
\ provisioning |    Docker/Podman
\              |       compose
\              |
\          Developer
\          environment
\
\ 1 - The self hosted services will by anything that I chose to run
\ 2 - Grafana will be prefer to run on a High available machine
\______________________________________________________________________________________________

```

Shortly the cluster and it's alias are:
| Machine | Alias| OS |
| :--- | :--- | :--- |
| Acer Aspire One Kav60 | Atom | Debian 12 (bookworm) |
| Galaxy A15 | Pawn | Android/Termux |
| Galaxy book 4 | Gray | Mint zena |

Briefly, the role-machine relation will be:

| Role | Tool | Machine |
| :--- | :--- | :--- |
| reverse proxy server | Cloudflared/Nginx | Pawn/Atom |
| 24/7 hosted services | Podman compose | Atom |
| Heavy non-constant services | Docker compose | Gray |
| documentation | MkDocs web-pages | Atom |
| provisioning | Ansible | Gray |
| CI/CD | GitHub actions | Gray |
| cloud provisioning | AWS/terraform | Gray|

You can access the current state of the project from inside checking out [my personal domain](https://thecodinglaplace.com.br)

## Choices and flux

Currently, while I'm finishing preparing mostly of the documentation, I'm serving already an preview in a homologation eviroment, and the flux is quite simple:

```ASCII
\ _____________________________________________________________________________________ #
\
\ - Exec [repo-provisioning.yaml](./playbooks/repo-provisioning.yaml) 
\   |__ > in dev-station
\   |__ > using ssh-agent fowarding to validate the ssh-key *
\ 
\ - Connect via ssh in atom
\ - Exec [init-homolog.sh](./scripts/init-homolog.sh)
\   |__ > Donwload the dependencies
\   |__ > Start the http tunnel and the API
\   |__ > Build documentation via mkdocs
\   |__ > Clean and start again the logs on a temporary sub-directory
\   |__ > via nohup*
\   
\   And start the engine ;)
\ _____________________________________________________________________________________ #
```
* Personaly I use gh, the github oficial general cli tool to connect my machine to my account, and for safety reasons, I use ssh-keys reather then passwords or classical tokens, so because of it I put at running time my ssh-key to validade de repo in all the cluster machines. More info about that when documentation is ready. 

* Nohup is a way to exec a command in a remote machine via ssh in the with does not require the command to me to remain in the session to keep working, so if I didn't do that I'd be forced to keep the ssh session open just to keep the eviroment up, which goes exacly againts the objective: Be an already high avalible eviroment to test.

Regardless of what I could or could not be the best way to do what I'm doing I think it is important, specially for my scenario, to scale laywer by laywer of abstraction and tool
