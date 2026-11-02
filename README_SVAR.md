# Besvarelse

## Oppgave 1

### 1A

Først må et image bygges, jeg gir det taggen wishifai.

```
docker build -t wishifai .
```

Etter at imaget har blitt bygget så kan man starte en container med denne kommandoen.

```
docker run -p 9999:8080 wishifai
```

### 1B

Lenke til grønn kjøring: https://github.com/taffolds/eksamen-2026/actions/runs/41208422393

Commit-SHA har blitt brukt som tagging strategi. Dette er fordi det er statistisk veldig usannsynlig at to filer lager samme SHA, selv en liten endring i filen vil skape en helt annerledes SHA. Jeg har valgt å bruke --short da det fortsatt er svært usannsynlig at de første syv hexadecimale tallene blir like. Dette gjør at hver endring blir lett å spore fra image til en spesifikk GitHub commit.

## Oppgave 2

### 2A

Jeg har bestemt meg for separere ut IAM roller i en separat fil iam.tf for at main.tf skal inneholde mindre kode.
Offentlig URL til tjenesten: https://wi-85046072fab9462c8d3542d3075ff0e0.ecs.eu-west-1.on.aws

### 2B

Jeg har valgt å bruke mitt eget kandidatnummer som nøkkel. Dette kan bli sett på som en egen filsti inne i pgr301-terraform-state bucketen, slik at man unngår å skrive filer til andres directories. Jeg har på use_lockfile = true slik at kun en prosess kan bruke den av gangen. Dette gjør at man slipper å korrupte terraform.tfstate filen, og at man ikke får race conditions hvor to forskjellige pipeline-kjøringer kan få konflikt over hvordan staten skal være.