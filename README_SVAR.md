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