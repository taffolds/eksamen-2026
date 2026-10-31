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

Commit-SHA har blitt brukt som tagging strategi. Dette er fordi det er statistisk veldig usannsynlig at to filer lager samme SHA, selv en liten endring i filen vil skape en helt annerledes SHA. Dette gjør at hver endring blir lett å spore fra image til en spesifikk GitHub commit.