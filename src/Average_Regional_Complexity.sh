#!/bin/bash
#
#-----------------------------------
#Variables
#-----------------------------------
Run_Average_Regional_NC=1;

#-----------------------------------
# Run Average Regional NC
#-----------------------------------

if [[ "$Run_Average_Regional_NC" -eq "1" ]]; then

    declare -a NAMES=( "ALBRECHT_DURER" "AMEDEO_MODIGLIANI" "ANDREA_MANTEGNA" "ANDY_WARHOL" "ARSHILLE_GORKY" "CAMILLE_COROT" "CARAVAGGIO" "CASPAR_DAVID_FRIEDRICH" "CLAUDE_LORRAIN" "CLAUDE_MONET" "DANTE_GABRIEL_ROSSETTI" "DAVID_HOCKNEY" "DIEGO_VELAZQUEZ" "EDGAR_DEGAS" "EDVARD_MUNCH" "EDWARD_HOPPER" "EGON_SCHIELE" "EL_LISSITZKY" "EUGENE_DELACROIX" "FERNAND_LEGER" "FRANCISCO_DE_GOYA" "FRANCISCO_DE_ZURBARAN" "FRANCIS_BACON" "FRANS_HALS" "FRANZ_MARC" "FRA_ANGELICO" "FRIDA_KAHLO" "Frederic_Edwin_Church" "GENTILESCHI_ARTEMISIA" "GEORGES_BRAQUE" "GEORGES_DE_LA_TOUR" "GEORGES_SEURAT" "GEORGIA_OKEEFE" "GERHARD_RICHTER" "GIORGIONE" "GIORGIO_DE_CHIRICO" "GIOTTO_DI_BONDONE" "GUSTAVE_COURBET" "GUSTAVE_MOREAU" "GUSTAV_KLIMT" "HANS_HOLBEIN_THE_YOUNGER" "HANS_MEMLING" "HENRI_MATISSE" "HIERONYMUS_BOSCH" "JACKSON_POLLOCK" "JACQUES-LOUIS_DAVID" "JAMES_ENSOR" "JAMES_MCNEILL_WHISTLER" "JAN_VAN_EYCK" "JAN_VERMEER" "JASPER_JOHNS" "JEAN-ANTOINE_WATTEAU" "JEAN-AUGUSTE-DOMINIQUE_INGRES" "JEAN-MICHEL_BASQUIAT" "JEAN_FRANCOIS_MILLET" "JOACHIM_PATINIR" "JOAN_MIRO" "JOHN_CONSTABLE" "JOSEPH_MALLORD_WILLIAM_TURNER" "KAZIMIR_MALEVICH" "LUCIO_FONTANA" "MARC_CHAGALL" "MARK_ROTHKO" "MAX_ERNST" "NICOLAS_POUSSIN" "PAUL_CEZANNE" "PAUL_GAUGUIN" "PAUL_KLEE" "PETER_PAUL_RUBENS" "PIERRE-AUGUSTE_RENOIR" "PIETER_BRUEGEL_THE_ELDER" "PIET_MONDRIAN" "Picasso" "RAPHAEL" "REMBRANDT_VAN_RIJN" "RENE_MAGRITTE" "ROGER_VAN_DER_WEYDEN" "ROY_LICHTENSTEIN" "SALVADOR_DALI" "SANDRO_BOTTICELLI" "THEODORE_GERICAULT" "TINTORETTO" "TITIAN" "UMBERTO_BOCCIONI" "VINCENT_VAN_GOGH" "WASSILY_KANDINSKY" "WILLEM_DE_KOONING" "WILLIAM_BLAKE" "WILLIAM_HOGARTH" "WINSLOW_HOMER" "DOUARD_MANET" )
    number_painters=$(echo "${#NAMES[@]}");
    for a in `seq 1 $number_painters `;
        do
        echo "scale=0; ($a * 16777216) / $number_painters " | bc -l >> TMP_color
    done 
    rm ../reports/REPORT_AVG_REGIONAL_COMPLEXITY_PER_BLOCK_256
    ncols=$(awk '{print NF}' ../reports/REPORT_REGIONAL_COMPLEXITY_256_Quantizing8 | sort -nu | tail -n 1);
    number_cols="$(($ncols-1))" 
    for i in "${NAMES[@]}"
    do  
       printf "%s\t" $i >> ../reports/REPORT_AVG_REGIONAL_COMPLEXITY_PER_BLOCK_256;

        for a in `seq 1 $number_cols `;
            do
            cat ../reports/REPORT_REGIONAL_COMPLEXITY_256_Quantizing8 | grep -a $i | awk -F ":" '{print $2}' > TT;
            awk -v var="$a" -F " \t" '{print $var}' TT  > TTMP;
            SUM=$(awk 'BEGIN {t=0}; {t+=$1} END {print t}' TTMP);
            CAR=$(cat TTMP | wc -l )
            echo "scale=8; ($SUM / $CAR)" | bc -l | awk '{printf "\t%f\t", $0}' >> ../reports/REPORT_AVG_REGIONAL_COMPLEXITY_PER_BLOCK_256;
        done
        printf "\n" >> ../reports/REPORT_AVG_REGIONAL_COMPLEXITY_PER_BLOCK_256;
    done
    rm TT TTMP;
    exit;
fi