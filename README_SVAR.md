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

### 2C

Terraform kjører etter container-build, da den avhenger av at imaget faktisk eksisterer i registry til ECR. Hvis den ikke hadde gjort det, så hadde potensielt terraform laget container av feil image, avhengig av når de to jobbene ble ferdige.

Lenke til grønn kjøring: https://github.com/taffolds/eksamen-2026/actions/runs/41438374582

## Oppgave 3

### 3A

Jeg har valgt å lage to businessmetrikker da jeg følte at det ga mer mening for applikasjonen. Jeg har valgt å lage en Counter for mengden bilder analysert. Dette gir innblikk i hvor mye tjenesten blir brukt. Jeg har valgt å ha counteren etter at Rekognition og Bedrock har blitt kalt slik at man får innsikt i hvor mange ganger analyse har skjedd, ikke bare hvor mange ganger endepunktet har blitt kalt.

Jeg har også valgt å bruke en DistributionSummary metrikk for å se hvor mange gaveforslag som blir sendt til til bruker. Det er interessant å vite om det alltid blir sendt tilbake 5 forslag, eller om det kanskje er mindre noen ganger. Jeg kommer også til å bruke denne metrikken i 3B for å sjekke om servicen plutselig sender flere enn 5 forslag til tross for at prompten spesifiserer maks 5 forslag, sånn at man får varsel om at LLMen ikke utfører instruksjonene riktig.