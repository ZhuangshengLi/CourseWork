#include <stdio.h>
#include <stdlib.h>
//Provides functions for comparing(strcmp()) ,copying characters(strdup()), string separation(strtok())
#include <string.h>

#define MAX_LEN_OF_LINE 101  //The maximum number of characters a line of input contains
#define MAX_LEN_OF_WORD 31   //The maximum number of characters a string contains

typedef struct TreeNode {
    char *word;
    int count;
    struct TreeNode *left;
    struct TreeNode *right;
}TreeNode;

struct TreeNode *addTree(struct TreeNode *node,const char *word);
void freeTree(struct TreeNode* root);
void toUpper(char *str);


int main() {

    freopen("2.txt", "r", stdin);

    char input[MAX_LEN_OF_LINE];

    char target[MAX_LEN_OF_WORD];
    scanf("%s", target);

    char searchword[MAX_LEN_OF_WORD];
    strcpy(searchword, target);
    //Target words are capitalized
    toUpper(searchword);

    //The target word is added to the tree as the root
    struct TreeNode *root = NULL;
    root = addTree(root, searchword);

    while(scanf("%s", input) != EOF){
        //Normalize(toUpper()) the characters on each line
        toUpper(input);
        const char delim[3] = {' '};
        //Separate each word with a space
        char *token = strtok(input, delim);

        //Iterate over the words in each line and add them to the tree
        while(token != NULL) {
            addTree(root, token);

            token = strtok(NULL, delim);
        }
    }

    //Because the target word is added to the tree, the root (the target word) count is decremented by one
    if(root->count > 1) printf("%s => %d", target, root->count - 1);
    else printf("** \"%s\" not found **", target);

    //Release the resources occupied by the tree
    freeTree(root);

    return 0;
}

//Build a binary search tree rooted at the target word according to the lexicographical order
TreeNode *addTree(TreeNode *node,const char *word)
{
    //Record the result of lexicographical order between the word that current node represents and the added word
    int con;
    TreeNode *tmp;
    //Create a node if there is no node for that word
    if(node == NULL)
    {
        node = (TreeNode *)malloc(sizeof(TreeNode));
        node->count = 1;
        node->word = strdup(word);
        node->left = node->right = NULL;
    }
    //Small lexicographically ordered numbers are recursively added to the left subtree
    else if((con = strcmp(word, node->word))<0)
    {
        tmp = addTree(node->left, word);
        node->left = tmp;
    }
    //Larger lexicographically ordered numbers are recursively added to the right subtree
    else if(con > 0)
    {
        tmp = addTree(node->right, word);
        node->right = tmp;
    }
    //Count plus 1 when encounter the same string
    else{
        node->count++;
    }
    return node;
}


//Releases the resources occupied by the tree recursively
void freeTree(TreeNode *root)
{
	if (root != NULL)
	{
		if (root->left != NULL)
		{
			freeTree(root->left);
			root->left = NULL;
		}
 		if (root->right != NULL)
 		{
 			freeTree(root->right);
 			root->right = NULL;
 		}
 		free(root);
 		root = NULL;
 	}
}

void toUpper(char *str) {
    for(int i = 0; i < strlen(str); i++){
        //Lowercase letters are converted to uppercase because 'A' and 'a' ASCII differ by 32
        if(str[i] >= 97 && str[i] <= 122) str[i] -= 32;
            //If not a letter, convert to space
        else if (str[i] < 65 || str[i] > 90) str[i] = ' ';
    }
}