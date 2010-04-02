# Create new .po files, for new languages for domains.
#

LOCALE_DIR=./locale

locale() {
    while [[ $1 != "" ]]; do
        for template in $LOCALE_DIR/*.pot
        do
            domain=$(basename $template .pot)
            mkdir -p $LOCALE_DIR/$1
            msginit -i $template -o $LOCALE_DIR/$1/$domain.po -l $1 --no-translator
        done        
        shift
    done
}


domain() {
    domain=$1; shift    
    if [ $# -gt 0 ]; then
        echo "Too many arguments: $@"
        return
    fi
    
    template=$LOCALE_DIR/${domain}.pot
    if [ ! -f $template ]; then
        echo "Template file for this domain doesn't exist: $template"
        return
    fi
        
    for langdir in $LOCALE_DIR/*/
    do
        msginit -i $template -o "${langdir}${domain}.po" -l $(basename $langdir) --no-translator
    done
}


command=$1; shift
case "$command" in
    locale) locale $*;;
    domain) domain $*;;
    *) if [ "$1" == "" ]; then
         echo "You need to specify a command."
         echo ""
         echo "$0 locale de fr"
         echo "      Create .po files for the given languages for all existing domains."
         echo "$0 domain newdomain"
         echo "      Create .po files for all existing languages based on the given domain (existing .pot file)."
       else
           echo "Invalid command: $command" 1>&2
       fi
       exit 1;;
esac

