<template>
  <div class="avatar-loader" :class="{ 'no-pointer-events': !item.id }">
    <v-hover v-slot:default="{ hover }">
      <v-avatar color="primary" v-if="item.photo === null" :size="size">
        <img v-if="icon === undefined" src="/img/no-profile-picture.jpg" />
        <v-icon v-else dark :size="size * 0.7" v-text="icon"></v-icon>
        <v-slide-y-reverse-transition>
          <div class="photo-actions" v-show="hover">
            <div @click="$refs.input.click()">
              <v-icon>arrow_upward</v-icon>
              <span>загрузить</span>
            </div>
          </div>
        </v-slide-y-reverse-transition>
      </v-avatar>
      <v-avatar v-else :size="size">
        <!-- <v-fade-transition>
          <div class="avatar-loader__overlay" v-show="hover"></div>
        </v-fade-transition> -->
        <img :src="item.photo.url_version" />
        <v-slide-y-reverse-transition>
          <div class="photo-actions" v-show="hover">
            <div @click="$refs.input.click()">
              <v-icon>add_a_photo</v-icon>
              <span>новое</span>
            </div>
            <div @click="confirmRemoveDialog = true">
              <v-icon>close</v-icon>
              <span>удалить</span>
            </div>
          </div>
        </v-slide-y-reverse-transition>
      </v-avatar>
    </v-hover>
    <input
      ref="input"
      type="file"
      name="image"
      accept="image/*"
      @change="setImage"
    />
    <v-dialog v-model="dialog" width="1000px">
      <v-card>
        <div class="pa-2">
          <vue-cropper
            ref="cropper"
            :aspect-ratio="1"
            :src="imgSrc"
            :zoomable="false"
            :view-mode="1"
            :min-crop-box-width="100"
            :min-crop-box-height="100"
            :min-container-height="600"
            :min-container-width="968"
            :responsive="false"
          />
        </div>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="dialog = false">отмена</v-btn>
          <v-btn color="primary" :loading="saving" @click="save()"
            >сохранить</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="confirmRemoveDialog" width="350">
      <v-card>
        <v-card-title>Удалить фото?</v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="confirmRemoveDialog = false">
            Отмена
          </v-btn>
          <v-btn color="primary" @click="remove()">
            Да
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import VueCropper from "vue-cropperjs"
import "cropperjs/dist/cropper.css"
const API_URL = "photos"

export default {
  props: {
    item: {
      type: Object,
      required: true,
    },

    entityType: {
      type: String,
      required: true,
    },

    size: {
      type: Number,
      default: 180,
    },

    icon: {
      type: String,
    },
  },

  components: { VueCropper },

  data() {
    return {
      dialog: false,
      saving: false,
      imgSrc: undefined,
      confirmRemoveDialog: false,
    }
  },

  methods: {
    setImage(e) {
      const file = e.target.files[0]
      if (file.type.indexOf("image/") === -1) {
        alert("Please select an image file")
        return
      }
      if (typeof FileReader === "function") {
        const reader = new FileReader()
        reader.onload = event => {
          this.imgSrc = event.target.result
          this.dialog = true
          if (this.$refs.cropper !== undefined) {
            this.$refs.cropper.replace(event.target.result)
          }
        }
        reader.readAsDataURL(file)
      } else {
        alert("Sorry, FileReader API not supported")
      }
    },

    save() {
      this.saving = true
      this.$refs.cropper.getCroppedCanvas().toBlob(
        blob => {
          const formData = new FormData()
          if (this.item.photo !== null) {
            formData.append("photo_id", this.item.photo.id)
          }
          formData.append("photo", blob)
          formData.append("entity_id", this.item.id)
          formData.append("entity_type", this.entityType)
          this.$http.post(API_URL, formData).then(r => {
            this.item.photo = r.data
            this.dialog = false
            setTimeout(() => (this.saving = false), 300)
          })
        },
        "image/jpeg",
        0.9,
      )
    },

    remove() {
      this.$http.delete(`${API_URL}/${this.item.photo.id}`)
      this.item.photo = null
      this.confirmRemoveDialog = false
    },
  },
}
</script>

<style lang="scss">
.avatar-loader {
  & .v-avatar {
    overflow: hidden;
  }
  &__overlay {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background: black;
    opacity: 0.3;
  }
}

.photo-actions {
  position: absolute;
  background: rgba(29, 32, 34, 0.7);
  color: white;
  height: 36%;
  width: 100%;
  bottom: 0;
  padding-top: 5px;
  & .v-icon {
    color: white;
    height: 16px;
    font-size: 18px;
    margin-right: 4px;
  }
  & > div {
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    opacity: 0.8;
    cursor: pointer;
    margin-bottom: 10px;
    &:hover {
      opacity: 1;
    }
  }
}

.cropper-crop-box,
.cropper-view-box {
  border-radius: 50%;
}

.cropper-view-box {
  outline: 0;
}
</style>
