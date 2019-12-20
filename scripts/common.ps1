function generateName($blueprintName, $blueprintVersion){
    $joined = -join($blueprintName, $blueprintVersion)
    return $joined.Replace(".","")
}