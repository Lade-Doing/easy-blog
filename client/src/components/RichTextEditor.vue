<!-- 富文本组件 -->
<template>
    <div>
        <Toolbar :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode"
            style="border-bottom: 1px solid #ccc" />
        <Editor :defaultConfig="editorConfig" :mode="mode" v-model="valueHtml" style="height: 400px; overflow-y: hidden"
            @onCreated="handleCreated" @onChange="handleChange" />
    </div>
</template>

<script setup>
import '@wangeditor/editor/dist/css/style.css';
import { ref, reactive, inject, onMounted, onBeforeUnmount, shallowRef } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue';

const server_url = inject("server_url")
// 编辑器实例，必须用 shallowRef，重要！
const editorRef = shallowRef();
const toolbarConfig = { excludeKeys:["uploadVideo"] };
const editorConfig = { placeholder: '请输入内容...' };
editorConfig.MENU_CONF = {}
editorConfig.MENU_CONF['uploadImage'] = {
    base64LimitSize: 10 * 1024, // 10kb
    server: server_url+'/upload/file',
}
//对于后端返回的url只有/upload后端的内容，并没有http://localhost:3000，所以这里做个处理。
editorConfig.MENU_CONF['insertImage'] ={
    parseImageSrc:(src) =>{
        if(src.indexOf("http") !==0){
            return `${server_url}${src}`
        }
        return src
    }
}

const mode = ref("default")
const valueHtml = ref("")

const props = defineProps({
    modelValue: {
        type: String,
        default: ""
    }
})

const emit = defineEmits(["update:model-value"])
let initFinished = false

onMounted(() => {
    setTimeout(() => {
        valueHtml.value = props.modelValue;
        initFinished = true;
    }, 10);
});

// 组件销毁时，也及时销毁编辑器，重要！
onBeforeUnmount(() => {
    const editor = editorRef.value;
    if (editor == null) return;
    editor.destroy();
});

// 编辑器回调函数
const handleCreated = (editor) => {
    console.log('created', editor);
    editorRef.value = editor; // 记录 editor 实例，重要！
};
const handleChange = (editor) => {
    if (initFinished) {
        emit("update:model-value", valueHtml.value)
    }
};

</script>

<style lang="scss" scoped>
</style>