for d in SEC/*; do
    DIR=$d"/SupportingFiles/Generated"
    RSWIFT_FILE='R.generated.swift'
    NEEDLE_FILE='Needle.generated.swift'

    echo "⚙️  Generating file: $DIR/$FILE"
    mkdir -p "$DIR"
    touch "$DIR/$RSWIFT_FILE"
    touch "$DIR/$NEEDLE_FILE"
done
