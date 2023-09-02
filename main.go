package main

import (
	"io"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		io.WriteString(w, "Hello, 世界")
	})

	http.HandleFunc("/api/health_checks/ready", func(w http.ResponseWriter, r *http.Request) {
		// Check if everything is okay.
		// - Ping databases
		// - Ping message brokers
		// - etc.

		// If everything is okay...
		io.WriteString(w, "READY")
	})

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
