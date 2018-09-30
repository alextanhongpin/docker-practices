package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("PORT")
	host := os.Getenv("HOST")
	b, err := ioutil.ReadFile("/my-config")
	if err != nil {
		log.Fatal(err)
	}
	log.Println("got config", string(b))

	s, err := ioutil.ReadFile("/run/secrets/my-secret")
	if err != nil {
		log.Fatal(err)
	}
	log.Println("got secret", string(s))

	mux := http.NewServeMux()
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, `ok`)
	})
	addr := fmt.Sprintf("%s:%s", host, port)
	log.Printf("listening to server %s\n", addr)
	http.ListenAndServe(addr, mux)
}
