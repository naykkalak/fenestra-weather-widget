#!/bin/sh
# Fenestra Weather Widget - installation / mise à jour / désinstallation (Plasma 6)
#
# Usage :
#   ./install.sh                 installe le widget (ou le met à jour s'il est déjà installé)
#   ./install.sh --uninstall     désinstalle le widget
#
# Le widget est installé pour l'utilisateur courant (~/.local/share/plasma/plasmoids).
# Aucun droit administrateur n'est nécessaire. Plasma n'est pas redémarré :
# si le widget n'apparaît pas tout de suite dans « Ajouter des widgets »,
# fermez puis rouvrez cette fenêtre, ou ouvrez une nouvelle session.

set -eu

ID="org.fenestra.weather"
ICI=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CIBLE="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/plasmoids/$ID"

if [ "${1:-}" = "--uninstall" ] || [ "${1:-}" = "--desinstaller" ]; then
    if command -v kpackagetool6 >/dev/null 2>&1; then
        kpackagetool6 -t Plasma/Applet -r "$ID" || true
    fi
    if [ -d "$CIBLE" ]; then
        rm -rf "$CIBLE"
    fi
    echo "Fenestra Weather Widget désinstallé."
    exit 0
fi

if [ ! -f "$ICI/metadata.json" ] || [ ! -d "$ICI/contents" ]; then
    echo "ERREUR : metadata.json ou contents/ introuvable à côté de install.sh." >&2
    echo "Lancez ce script depuis le dossier du widget." >&2
    exit 1
fi

# Copie de travail sans install.sh ni fichiers parasites : seul le widget est installé.
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT INT TERM
mkdir -p "$TMP/$ID"
cp -R "$ICI/metadata.json" "$ICI/contents" "$TMP/$ID/"
for f in LICENSE LICENSE.txt COPYING README.md README.txt CHANGES.txt; do
    [ -f "$ICI/$f" ] && cp "$ICI/$f" "$TMP/$ID/" || true
done

if command -v kpackagetool6 >/dev/null 2>&1; then
    if [ -d "$CIBLE" ]; then
        echo "Mise à jour de $ID ..."
        kpackagetool6 -t Plasma/Applet -u "$TMP/$ID"
    else
        echo "Installation de $ID ..."
        kpackagetool6 -t Plasma/Applet -i "$TMP/$ID"
    fi
else
    echo "kpackagetool6 est introuvable : copie directe dans $CIBLE"
    mkdir -p "$(dirname "$CIBLE")"
    rm -rf "$CIBLE"
    cp -R "$TMP/$ID" "$CIBLE"
fi

echo
echo "Terminé. Clic droit sur le bureau ou le panneau > Ajouter des widgets > « Fenestra Weather »."
