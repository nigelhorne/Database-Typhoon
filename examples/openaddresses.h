/*---------- headerfile for openaddresses.ddl ----------*/
/* alignment is 8 */

/*---------- structures ----------*/
struct addresses {  /* size 159 */
    double  lat;
    double  lon;
    unsigned long    number;
    char    street[33];
    char    city[33];
    char    county[33];
    char    state[33];
    char    country[3];
};

struct all {  /* size 143 */
    unsigned long    number;
    char    street[33];
    char    city[33];
    char    state[33];
    char    county[33];
    char    country[3];
};

/*---------- record names ----------*/
#define ADDRESSES 1000L

/*---------- field names ----------*/
#define LAT 1001L
#define LON 1002L
#define NUMBER 1003L
#define STREET 1004L
#define CITY 1005L
#define COUNTY 1006L
#define STATE 1007L
#define COUNTRY 1008L

/*---------- key names ----------*/
#define ALL 0

/*---------- sequence names ----------*/

/*---------- integer constants ----------*/
