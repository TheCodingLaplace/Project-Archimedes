# Quick-start
## Little disclaimer
Wellcome, you are in the mkdocs documentation page of Archimedes itself, stick around for a bit 'cause I would like to clarify some things before we continue.

First of all, and this is quite important if you are alredy familiar with some programing concepts, this web page in here is a separate process of my main API for now, so it can happens, sometimes, the layout may be broken, the process may not be avalible or simply the page/machine could get down, so I will asure the at the very bottom least the home-page of the domain be always-on, so I gently ask you, the reader, for feedback in any failures that I might stamble upon to.

If the up case is yours, follow this simple guidance:

- go to [my_home_page](https://thecodinglaplace.com.br) 
- look at the botom part of it and send me a feedback about your experience, in your prefered way 

I also will accept complements too, It could be whatsapp, e-mail or likedin, and I'll make sure more ways be possible too sonner.

So with all that in Mind, let's start with the proper documentation!

Obs: If U wish to skip this presentation part, the proper technical choices start in here 

## The concept

The project Archimedes born mostly as a learning enviroment not only to test, but also to prove my capacities as a worker in tech induestries. As already spoken in the [README-file](https://github.com/TheCodingLaplace/Project-Archimedes/blob/main/README.md) of the project, the idea is to simulate an real self-hosted architecture of services, with focus mainly on the DevOps part of the project.

So, to attempt this state I begin to abstract firstly the structure behind everything, and also, to constrain myself, I did not allow me to use clould computing eviroments to first learn the fundamentals behind the operational system - the OS - and futher in the technical choices it will be clear how this gave me a deep understand of the abstrat tools that not only I am or will be using to maintain the whole, but also know when do or do not use 'em in order to avoid the deepest constrain of all: **_Computing power_**

## _"If the code runs, it runs somewhere..."_

One of the commons necessity of an enterprise to runs it's own software/service is to have a _host_, this is, _to have a machine who runs the code to sustains it all_. Currently I poses three working machines:

- A 2008 old netbook, which is the one serving this webpage right now
- A cellphone, more modern and even stronger then the netbook above
- A laptop, the main orchestrator and my dev station

And despite the fact that those are not enterprise hardware, it already gives me a good amount of computing that I can use, but also restrics me - or better, forces me - into learn to not waste their potential, while also prevents me to have aditional cost. Each one of those is, in modern standarts, modified to serve a role in the architecture considering their strengs and failures. 

For instance and example, the laptop could in fact host it all, but besides that and also being a single point of failure, the netbook is better to run 24/7 services like this documentation simply because it can be a stationary machine and draws a fraction of the eletrical power while also being better then the cellphone for having proper separation, user freedon and modification of hardware without the constrains of not having tools like super user control - 'sudo' usage - and upgrade of pieces.

    Dev note 24/09: The rest of the documentation will be comming ASAP. 