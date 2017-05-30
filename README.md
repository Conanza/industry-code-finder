# Industry Code Finder
A microservice for looking up industry codes

## How to Use
Interfacing with the lookup microservice is achieved with a REST API and served through industry-code-finder.herokuapp.com. The API currently only supports lookup by a single class code, defined by a code number and its classification system, and is designed to respond with a JSON object containing cross-referenced industry codes, along with their respective descriptions.

### API Examples

Class code lookup is done via POST requests to `/lookup`

1. Requesting a lookup from the terminal
```
  curl -X POST -H "Content-Type: application/json" -d '{"query": {"class_system": "CA", "code_number": "1741"} }' industry-code-finder.herokuapp.com/lookup
```

2. Client-side lookup (jQuery)
```javascript
  $.ajax({
     method: "POST",
     url: "http://industry-code-finder.herokuapp.com/lookup",
     data: {
       query: {
         class_system: "CA",
         code_number: 1741
       }
     }
  });
```

### Request Format
However you send the request, the data payload should be of JSON format

```JSON
{
  "query": {
    "class_system": "<class_system>",
    "code_number": "<code_number"
  }
}
```
`class_system` can be any one of the following (case insensitive): `SIC`, `NAICS`, `NCCI`, `CA`  
`code_number` the industry code number you're looking up

### Response
The server returns a JSON object containing  

`query_params` object
  * containing original query params, `class_system` and `code_number`  

and if successful lookup,  

`cross_references` object
  * keyed by the different types of classification systems, contains lists of codes that cross reference the original lookup code, along with a list of the descriptions that describe each pairing for each mapping
  * `general_descriptions` and `iso_descriptions` lists for aggregate lists of all cross referenced descriptions


### Tools
[poppler](https://poppler.freedesktop.org/)  
[pdftables](https://pdftables.com/)

### References
[Stack Overflow post](https://stackoverflow.com/questions/41913796/extracting-tables-from-pdf-files-in-ruby)
