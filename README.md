# multivm-app - Timezone Converter

A basic timezone converter using a webpage as a form for users. Currently there are only a small number of timezones available for conversion. 

## Prerequisites
- To use this application VirtualBox and Vagrant are required.
  - Get VirtualBox at https://www.virtualbox.org/wiki/Downloads
  - Get Vagrant at https://www.vagrantup.com/downloads.html

## Clone the application:
- Clone the repository ```git clone https://github.com/Zyviax/multivm-app.git```

## Build the application:
- Change into the directory ```cd multivm-app```
- Start application ```vagrant up```
  - This may take a few minutes depending if you already have the Vagrant box files or not.

## Use the application:
- To use application go to http://localhost:8080
- Fill the form: selecting time, date, and the timezones.
  - It will then show the time and date in the converted timezone.
  - It will also generate a table of time conversions in a pdf.
  
## Example usage:

The following examples are the output pages of using web form.

(note that trying to access the pdf generated before going to the resulting page, will result in nothing being displayed)

- Converting 12am 15/01/2020 (DD/MM/YYYY) GMT to NZST
  - Resulting page: http://localhost:8080/index.php?time=00%3A00&date=2020-01-15&from=GMT&to=NZST
  - Pdf generated: http://localhost:8080/conversions/GMTtoNZST.pdf
  
- Converting 3am 24/07/2003 (DD/MM/YYYY) AEST to JST
  - Resulting page: http://localhost:8080/index.php?time=03%3A00&date=2003-07-24&from=AEST&to=JST
  - Pdf generated: http://localhost:8080/conversions/AESTtoJST.pdf
  
- Converting 11:59pm 31/08/2020 (DD/MM/YYYY) NZST to AoE
  - Resulting page: http://localhost:8080/index.php?time=23%3A59&date=2020-08-31&from=NZST&to=AoE
  - Pdf generated: http://localhost:8080/conversions/NZSTtoAoE.pdf
  
