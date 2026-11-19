# Translation Output Examples

Examples of how the different engines translate typical Pi-hole UI strings.

## English → Spanish

| English          | Argos Translate     | Marian / OPUS-MT (typical) |
|------------------|---------------------|----------------------------|
| Dashboard        | Tablero             | Panel de control           |
| Query Log        | Registro de consultas | Registro de consultas    |
| Whitelist        | Lista blanca        | Lista blanca               |
| Blacklist        | Lista negra         | Lista negra                |
| Enable           | Activar             | Habilitar                  |
| Disable          | Desactivar          | Desactivar                 |
| Settings         | Ajustes             | Configuración             |
| Status           | Estado              | Estado                     |

## English → Hindi

| English          | Typical output                  |
|------------------|---------------------------------|
| Dashboard        | डैशबोर्ड / डैशबोर्ड                        |
| Settings         | सेटिंग्स / सेटिंग्स                      |
| Enable           | सक्षम करें                           |
| Disable          | अक्षम करें                         |
| Save             | सहेजें                              |

## Notes
- Results vary slightly between engines and model versions.
- Short UI strings often need manual review (context is limited).
- Always prefer reviewed translations over raw machine output for the final locale files.
