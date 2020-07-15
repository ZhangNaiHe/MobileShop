<template>
  <div>
    <van-uploader :after-read="afterRead" v-model="fileList"/>
    <input type="file" @change="addFile" ref="fileDom" id="file">
  </div>
</template>

<script>
export default {
  data () {
    return {
      fileList: [],
      fil: {}
    }
  },
  methods: {
    beforeRead (file) {
      console.log(file)
      return true
    },
    afterRead (file) {
      // 此时可以自行将文件上传至服务器
      console.log(file.file)
      let formData = new FormData()
      formData.append('img', file.file)
      console.log(formData.get('img'))
      this.$http.post('/demo', { 'img': file.file }).then(() => {
        console.log('yes')
      })
    },
    addFile () {
      let dom = this.$refs.fileDom
      console.log(dom.files)
    }
  }
}
</script>

<style>
</style>
