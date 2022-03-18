provider "google" {
  credentials = "/home/yuriivatsyk/gcp-lab-terraform/application_default_credentials.json"
  project     = "zinc-sanctuary-339216"
  region      = "us-west1"
  zone        = "us-west1-b"
}

resource "google_compute_instance" "vm_instance" {
  count        = 5
  name         = "test-${count.index}"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  metadata_startup_script = file("./script.sh")

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  #   metadata = {
  #   ssh-keys = "yuriivatsyk:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuSjVoc00QAzHES83wjGCnQolbUNt8woXhSCxvKK3gspug/Iu2XXhGPNQ8o/U+hEfmLwmIbgNHcZj6Wg4IYkUEJMlNVhweQumGgsCU8nGIujIJVys0MDnVJdxhGh19Fr2W7lN+Ib2A9DJJFK03XW8xdTU5rG8ZSHp+iKix0jYZna8MXZoe+ozoH4UowKgO9VHAl6Wipz3GDKj/cmYiKEPx8ikYc/GwYvDijRRWFhJegJ5CaXF6t7EermnIbQEkp3qXvGNTiUk13DIxOU1GqgKlABZAEVoaGveHgoUU8cxUxjkV+jUFmCtrC7cvYBcDKYmw404lWkFHpnOMjHLNnuHJLeNDplISZv9qDiEu3Ndz/SCQaEXUP25t4QfF1Qr6Tn9W/E3g5N18R6yQk1kRNtFUZ3jyy70JjlIPkR7VliFR/ULAiiA2p3jSCb0unOZQYjjBrqGkuui8FK09GYfZ3L7pGMyt0LYo+06Mca5OBtbME0E82Tpgcjikp/75RKFKS2U= yuriivatsyk@IFLT-00012"
  # }


  network_interface {
    network = "default"
    access_config {
    }
  }
}