#include <stdio.h>

int main() {

    freopen("c.txt", "r", stdin);

    char ch;
    scanf("%c", &ch);
    //Print skips the first line
    getchar();

    if(ch == 'E'){
        scanf("%c", &ch);

        while(1){

            //The characters that differ from ch for the first time are recorded
            char next_ch = ch;
            //Record the number of character repeats
            int dup = 0;

            //Print directly when repeated less than three times, and then read a character
            while(next_ch == ch && dup < 3){
                dup++;
                printf("%c", ch);
                if(scanf("%c", &next_ch) == EOF) break;
            }

            //When the number of repetitions reaches 3, the last two digits represent the hexadecimal form of the count
            if(dup >= 3){
                char h_digit = next_ch;
                char l_digit;
                scanf("%c", &l_digit);

                int digit1 = h_digit - '9' > 0 ? h_digit - 'A' + 10 : h_digit - '0';
                int digit2 = l_digit - '9' > 0 ? l_digit - 'A' + 10 : l_digit - '0';

                //Ignore printed three times before
                int count = digit1 * 16 + digit2 - 3;

                for(int i = 0; i < count; i++) printf("%c", ch);

                //Start looking for the next set of characters
                if(scanf("%c", &ch) == EOF) break;
            }else ch = next_ch;    //Start looking for the next set of characters
        }
    }


    else if(ch == 'C'){
        scanf("%c", &ch);
        //Marks whether to read to the end of the file
        int flag = 0;

        while(1){
            //The characters that differ from ch for the first time are recorded
            char next_ch = ch;
            //Record the number of character repeats
            int dup = 0;

            //Iterates over a string of the same characters and counts
            while(next_ch == ch){
                dup++;
                if(dup <= 3) printf("%c", ch);

                //Exit the loop at the end of the file
                if(scanf("%c", &next_ch) == EOF){
                    flag = 1;
                    break;
                }
            }

            //If the number of repetitions exceeds 3, the count is converted to hexadecimal and printed
            if(dup >= 3){

                printf("%02X", dup);

            }
            //Exit the loop at the end of the file
            if(flag == 1) break;

            //Start looking for the next set of characters
            ch = next_ch;

        }

    }

    return 0;
} 




















