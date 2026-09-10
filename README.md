# Presentation (EN)

    The project-archimedes itself is my PoC (prove of concept) and my main arquitecture of my selfhosted cluster of services and computing nodes.

Here in this repo you, the reader, will find desciptions, technical choices, hardware/software trade-offs and work arounds that'll make this very unique and idiossincratic, besides the services and tecnologies itself that I host. It will be very clear along the way to an interest reader see, but regardless the fact that I'll pass through many aspects of all the tech roles that you can possibly imagine, curently I'm focusing in the DevOps maestry.

It is quite important to expose the core princibles of this project, those who are - _and will_ - be changed along the way as the repo and needs grows towards:

- **self-hosted first:** Up until this day I strongly believe that to have a strong knowledge of a tool or skill first you have to dig down to it's core and suporting axioms, so regardless fisical and financial limitations, I will always prefer to develop the structure of the whole within my own equipaments and machines. Every service or techinical choise whose won't follow that will be done with the proper trade-off and knowladge driven explanation.

- **agnostic of hardware:** Besided the impression of a contradiction, respecting my own limitations and the limitations of my machines, the project and architecture will always be built towars the largest amount of hardwares _and plataforms_, which includes cloud enviroments, old machines, non-porpused hardware, virtualized and bare metal. The only explict limitations whose I explicit compromise myself are the limitations of my knowledge and the atomistic ireduction and the software and services that I produce.

- **Driven to scale, limited by time:** Regardless of my personal will to spend 16h/day working in here, I soleny compromise myself as the only maintainer of this project, so create an idempotent non-needed-supervised enviroment is both skill and necessity.

- **Build, brake, fix, learn, repeat:** Don't mix yout expectations, this is and learning eviroment! I'll do anything in my power to simulate a real, formal, constrainted ambient to achive the best state of learn, but will won't be able to do so always, but that is the exactly state which I pursuit - learn fast and don't mess in real production.

## Curent arquitecture

At the curent state, I posses three working machines, each with it's specif limitation. You can check the the [detalled spec file in here](./ansible/cluster.yaml), which presents an yaml file describing each node of the cluster. 

Here's a quick diagram of the curent/planed worlflow, which may of may not be currently avalible:

```ASCII

\__________________________________________________________________________________________    
\    
\        user - web
\             |
\      personal domain -- \
\             |            \
\         HTTP tunel -- cloudflare ---------------------------------------
\             |                                                          |
\  Portifolio enviroment -- Documentation -- MKdocks webpages            |
\      /      |  \                                                       |
\     /       |   \                                                      |
\    /        |    Public perfomace dashboard -- Grafana ¹               |
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
\          enviroment
\
\ 1 - The self hosted services will by anything that I chose to run
\ 2 - Grafana will be preffer to run on a Hight avalible machine
\______________________________________________________________________________________________

```

Shortly the cluster and it's allias are:
| Machine | Allias| OS |
| :--- | :--- | :--- |
| Acer Aspire One Kav60 | Atom | Debian 12 (bookworm) |
| Galaxy A15 | Pawn | Android/Termux |
| Galaxy book 4 | Gray | Mint zena |

Brieffly, the role-machime relation will be:

| Role | Tool | Machine |
| :--- | :--- | :--- |
| reverse proxy server | Cloudflared/Nginx | Pawn/Atom |
| 24/7 hosted services | Podman compose | Atom |
| Heavy non-constant services | Docker compose | Gray |
| documentation | MkDocs web-pages | Atom |
| provisioning | Ansible | Gray |
| CI/CD | Github actions | Gray |
| cloud provisioning | AWS/terraform | Gray|

You can acess the curent state of the project from inside checking out [my personal domain](https://thecodinglaplace.com.br)

## Choices and flux