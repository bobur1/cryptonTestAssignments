<?php

$inputFileName = 'file.txt';
$outputFileName = 'array.txt';

$lines = readSomeFile($inputFileName);
$array = contentToArray($lines);

quickSort($array, 0, count($array) - 1);

file_put_contents($outputFileName, arrayToContent($array));

function readSomeFile($fileName) {
	$lines = [];
	$fopen = fopen($fileName, 'r');

	while (!feof($fopen)) {
	    $line=fgets($fopen);
	    $line=iconv('CP1251', 'UTF-8', trim($line));
	    $lines[]=$line;
	}

	fclose($fopen);

	return $lines;
}

function contentToArray($lines) {
	$array = [];
	$nameIndex = [];
	$counter = 0;

	foreach ($lines as $string)
	{
	    $string = preg_replace('!\s+!', ' ', $string);
	    $row = explode(" ", $string);
	    $name = $row[0];
	    $requestPerHour = $row[1];
	    $hours = $row[2];

	    if(array_key_exists($name, $nameIndex)) {
	    	$array[$nameIndex[$name]][1] += $requestPerHour;
	    	$array[$nameIndex[$name]][2] += $hours;
	    	$array[$nameIndex[$name]][3] += $requestPerHour * $hours;
	    } else {
			$array[$counter] = $row;
			$array[$counter][3] = $requestPerHour * $hours;
			$array[$counter][4] = $row[3];
			$nameIndex[$name] = $counter;
			$counter ++;
		}
	}

	return $array;
}

function quickSort(&$array, $left, $right) {
	$i = $left;
    $j = $right;
	
	if($left == $right) return;
    
    $pivotIndex = floor($left + ($right - $left) / 2);
    $pivotValue = firstLetterToHex($array[$pivotIndex][0]);
    
    while ($i <= $j) {
            while ((firstLetterToHex($array[$i][0]) < $pivotValue) ) {
                    $i++;
            }
            while (($pivotValue < firstLetterToHex($array[$j][0]) )) {
                    $j--;
            }
            if ($i <= $j ) {
                    $temp = $array[$i];
                    $array[$i] = $array[$j];
                    $array[$j] = $temp;
                    $i++;
                    $j--;
            }
    }

    if($left < $j) {
    	quickSort($array, $left, $j);
    }

    if($i < $right) {
    	quickSort($array, $i, $right);
    }

}

function firstLetterToHex($word) {
	return bin2hex(mb_substr($word, 0, 1));
}

function arrayToContent($array) {
	$content = "";

	foreach ($array as $key => $lines) {
		$content .= implode(' ', $lines) . PHP_EOL;
	}

	return $content;
}