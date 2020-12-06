Blocks.txt:
	wget https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt

SpecialCasing.txt:
	wget https://www.unicode.org/Public/UCD/latest/ucd/SpecialCasing.txt

UnicodeData.txt:
	wget https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt

encoding_data.h:
	for i in iso-8859-1 iso-8859-2 iso-8859-7 iso-8859-15 koi8-r cp437 cp737 cp850 cp852 cp858 cp866 cp1250 cp1251 cp1252 cp1253 ; do
		Unicode/cmpt_cp.pl -v $i
	done >> encoding_data.h

all:	Blocks.txt SpecialCasing.txt UnicodeData.txt encoding_data.h
