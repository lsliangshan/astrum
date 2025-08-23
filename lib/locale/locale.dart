import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      // 页面
      'tab.home': '首页',
      'tab.chat': '聊天',
      'tab.role': '角色',
      'tab.profile': '我的',

      'tab_role.title': '角色',

      'tab_chat.title': '聊天列表',

      'edit_role.title': '编辑角色',
      'add_role.title': '添加角色',
      'add_role.name': '角色名称',
      'add_role.name.hint': '请输入角色名称',
      'add_role.description': '角色描述',
      'add_role.description.hint': '请输入角色描述',
      'add_role.icon': '角色图标',
      'add_role.icon.hint': '请选择图标',
      'add_role.success': '角色添加成功',
      'add_role.error': '角色添加失败',

      'edit_role.success': '角色编辑成功',
      'edit_role.error': '角色编辑失败',

      'role_detail.title': '角色详情',
      'role_detail.base_info': '基础信息',
      'role_detail.attachments': '附件',
      'role_detail.no_attachments.tip': '暂无附件',
      'role_detail.chat': '聊天',
      'role_detail.authorName': '作者',
      'role_detail.btn_chat': '开始聊天',
      'role_detail.btn_fork': '添加到我的角色库',
      'role_detail.btn_unfork': '从我的角色库中移除',
      'role_detail.btn_add_role': '添加角色',
      'role_detail.add_role.success': '添加成功',
      'role_detail.add_role.failed': '添加失败',
      'role_detail.delete_role.success': '删除成功',
      'role_detail.delete_role.failed': '删除失败',

      'attachments.title': '附件管理',
      'attachments.from.upload': '从本地上传',
      'attachments.from.create': '创建新文件',
      'attachments.from.cancel': '取消',
      'attachments.uploading': '上传中...',
      'attachments.upload.failed': '上传失败',
      'attachments.upload.success': '上传成功',
      'attachments.delete.loading': '删除中...',

      // 创建附件页面
      'create_attachment.title': '创建附件',
      'create_attachment.file_name.label': '文件名',
      'create_attachment.file_name.hint': '请输入文件名',
      'create_attachment.default_name': '未命名',
      'create_attachment.btn.save': '保存',
      'create_attachment.valid.name.cannot_empty': '文件名不能为空',
      'create_attachment.file_content.hint': '请输入文件内容',
      'create_attachment.save.success': '保存成功',
      'create_attachment.save.failed': '保存失败',
      'create_attachment.valid.name.already_exists': '文件名已存在',

      'btn.cancel': '取消',
      'btn.save': '保存',
      'btn.delete': '删除',

      'snackbar.title': '提示',

      'language': 'zh_CN',
      'language.short': 'zh',

      'no_more_data': '没有更多数据了',

      'attachments.delete.title': '删除附件',
      'attachments.delete.content': '确定要删除附件“{filename}”吗？',
      'attachments.delete.confirm': '确定',
      'attachments.delete.cancel': '取消',
      'attachments.delete.success': '删除成功',
      'attachments.delete.failed': '删除失败',

      'login.login.title': '登录',
      'login.login.btn': '登录',
      'login.login.success': '登录成功',
      'login.login.error.username_not_exist': '用户名不存在',
      'login.login.error.password_error': '密码错误',
      'login.login.error.unknown': '登录失败，请稍后再试',
      'login.register.title': '注册',
      'login.register.btn': '注册',
      'login.register.success': '注册成功',
      'login.register.error.unknown': '注册失败，请稍后再试',
      'login.valid.username.can_not_empty': '用户名不能为空',
      'login.valid.password.can_not_empty': '密码不能为空',
      'login.valid.confirm_password.can_not_empty': '确认密码不能为空',
      'login.valid.confirm_password.not_match': '确认密码不匹配',
      'login.has_account': '已有账号，去登录',
      'login.no_account': '没有账号，去注册',
      'login.username': '用户名',
      'login.username.hint': '请输入用户名',
      'login.password': '密码',
      'login.password.hint': '请输入密码',
      'login.confirm_password': '确认密码',
      'login.confirm_password.hint': '请输入确认密码',

      'profile.title': '我的',
      'profile.anonymous': '未登录',
      'profile.logout': '退出登录',
      'profile.login': '登录',
      'profile.member_card.title': '我的账户',
      'profile.member_card.btn.subscribe': '开通会员',
      'profile.member_card.btn.renew': '续费',
      'profile.member_card.remaining_tokens': '剩余积分',
      'profile.member_card.vip_end': '会员到期时间',
      'profile.settings.exchange': '兑换码',
      'profile.language': '语言',
      'profile.language.en_US': '英语',
      'profile.language.zh_CN': '简体中文',

      // 发送机器人消息页面
      'chat_detail.title': '发送机器人消息',
      'chat_detail.hint_text': '请输入消息内容',
      'chat_detail.load_more_message': '加载更多消息',
      'chat_detail.no_more_message': '没有更多消息了',
      'chat_detail.has_new_message': '{count} 条新消息',
      'chat_detail.send_message': '按住 说话',

      'activation_code.title': '兑换码',
      'activation_code.hint': '请输入兑换码',
      'activation_code.btn.exchange': '立即兑换',
      'activation_code.btn.exchange.success': '兑换成功',
      'activation_code.btn.exchange.failed': '兑换失败',
      'activation_code.rule.title': '兑换码规则',
      'activation_code.rule.tip1': '1. 兑换账号为当前登录账号，兑换前请核实账号信息',
      'activation_code.rule.tip2': '2. 兑换码只能使用一次，一旦使用，概不退换',

      'member.card.title': 'VIP会员',
      'member.card.tip': '解锁共享礼簿等多项特权',
      'member.card.btn.buy': '去开通',
      'member.card.tip.subscription': '订阅即享：你的专属特权，从不打折！',

      'member.privilege.title': '会员特权',
      'member.privilege.massive.volume': '海量对话额度',
      'member.privilege.massive.volume.tip':
          '每月畅享 10万 积分，与AI深度对话，探索各种奇思妙想，无需为次数担忧。',
      'member.privilege.unlimited.creation': '角色创建自由',
      'member.privilege.unlimited.creation.tip':
          '最多可创建并发布20个专属角色，打造您的个人AI角色帝国，展现无限创造力。',
      'member.privilege.deep.knowledge': '深度知识库支持',
      'member.privilege.deep.knowledge.tip':
          '每个角色均可上传多达10个专属文件，构建更专业、更精准的AI大脑，解锁高质量对话。',
      'member.privilege.exclusive.access': '专属角色库通行证',
      'member.privilege.exclusive.access.tip':
          '无限制访问丰富多元的第三方角色市场，一键体验由精英创作者打造的优质角色，发现更多乐趣。',
      'member.privilege.early.access': '新功能优先体验权',
      'member.privilege.early.access.tip':
          '优先尝鲜最新产品和特性，快人一步感受AI科技的前沿魅力，成为我们的首席体验官。',
      'member.privilege.priority.support': '会员专属支持通道',
      'member.privilege.priority.support.tip': '享受优先技术支持，快速响应，解决您的问题更高效。',
      'member.privilege.service': '会员服务',
      'member.privilege.service.agreement': '会员服务协议',
      'member.privilege.service.faq': '会员常见问题',
      'member.privilege.activation.code': '使用激活码',
      'member.privilege.service.terms': '使用条款',
      'member.privilege.service.auto.renewal': '自动续订商品规则',
      'member.privilege.service.privacy': '隐私政策',
      'member.privilege.auto.renewal.subscription.terms': '自动续订商品规则',

      'settings.account.title': '删除账号',
      'settings.delete.account.title': '确认删除账号？',
      'settings.delete.account.tip':
          '您的账号数据（含个人信息、使用记录及已购会员权益）将永久删除且无法恢复，会员服务立即终止不退费；本地缓存数据（如临时文件等）需手动清理。此操作不可撤销，请务必提前备份重要信息！',
      'settings.delete.account.success.title': '账号删除成功',
      'settings.delete.account.failed.title': '账号删除失败',
      'settings.delete.account.success.tip':
          '您的账号已成功删除，所有相关数据也已从我们的系统中清除。如有疑问，请联系客户支持：cheenoalive@gmail.com',

      // 未登录页面
      'need_login.tip': '需要登录',
      'need_login.btn.login': '去登录',

      'no_data': '暂无数据',

      'anonymous': '匿名用户',
    },
    'en_US': {
      // 页面
      'tab.home': 'Home',
      'tab.chat': 'Chat',
      'tab.role': 'Role',
      'tab.profile': 'Profile',

      'tab_role.title': 'Role',

      'tab_chat.title': 'Chat List',

      'edit_role.title': 'Edit Role',
      'add_role.title': 'Add Role',
      'add_role.name': 'Name',
      'add_role.name.hint': 'Please enter the role name',
      'add_role.description': 'Description',
      'add_role.description.hint': 'Please enter the role description',
      'add_role.icon': 'Icon',
      'add_role.icon.hint': 'Please select the icon',
      'add_role.success': 'Role added successfully',
      'add_role.error': 'Role added failed',
      'edit_role.success': 'Role edited successfully',
      'edit_role.error': 'Role edited failed',

      'role_detail.title': 'Role Detail',
      'role_detail.base_info': 'Base Info',
      'role_detail.attachments': 'Attachments',
      'role_detail.no_attachments.tip': 'No attachments',
      'role_detail.chat': 'Chat',
      'role_detail.authorName': 'Author',
      'role_detail.btn_chat': 'Start Chat',
      'role_detail.btn_fork': 'Add to my role library',
      'role_detail.btn_unfork': 'Remove from my role library',
      'role_detail.btn_add_role': 'Add Role',
      'role_detail.add_role.success': 'Add Success',
      'role_detail.add_role.failed': 'Add Failed',
      'role_detail.delete_role.success': 'Delete Success',
      'role_detail.delete_role.failed': 'Delete Failed',

      'attachments.title': 'Attachments',
      'attachments.from.upload': 'Upload from local',
      'attachments.from.create': 'Create new file',
      'attachments.from.cancel': 'Cancel',
      'attachments.uploading': 'Uploading...',
      'attachments.upload.failed': 'Upload Failed',
      'attachments.upload.success': 'Upload Success',
      'attachments.delete.loading': 'Deleting...',

      // 创建附件页面
      'create_attachment.title': 'Create Attachment',
      'create_attachment.file_name.label': 'File Name',
      'create_attachment.file_name.hint': 'Please enter the file name',
      'create_attachment.default_name': 'Untitled',
      'create_attachment.btn.save': 'Save',
      'create_attachment.valid.name.cannot_empty': 'File name cannot be empty',
      'create_attachment.file_content.hint': 'Please enter the file content',
      'create_attachment.save.success': 'Save Success',
      'create_attachment.save.failed': 'Save Failed',
      'create_attachment.valid.name.already_exists': 'File name already exists',

      'btn.cancel': 'Cancel',
      'btn.save': 'Save',
      'btn.delete': 'Delete',

      'snackbar.title': 'Hint',

      'language': 'en_US',
      'language.short': 'en',

      'no_more_data': 'No more data',

      'attachments.delete.title': 'Delete Attachment',
      'attachments.delete.content':
          'Are you sure you want to delete the attachment “{filename}”?',
      'attachments.delete.confirm': 'Confirm',
      'attachments.delete.cancel': 'Cancel',
      'attachments.delete.success': 'Delete Success',
      'attachments.delete.failed': 'Delete Failed',

      'login.login.title': 'Login',
      'login.login.btn': 'Login',
      'login.login.success': 'Login Success',
      'login.login.error.username_not_exist': 'Username not exist',
      'login.login.error.password_error': 'Password error',
      'login.login.error.unknown': 'Login failed, please try again later',
      'login.register.title': 'Register',
      'login.register.btn': 'Register',
      'login.register.success': 'Register Success',
      'login.register.error.unknown': 'Register failed, please try again later',
      'login.valid.username.can_not_empty': 'Username cannot be empty',
      'login.valid.password.can_not_empty': 'Password cannot be empty',
      'login.valid.confirm_password.can_not_empty':
          'Confirm password cannot be empty',
      'login.valid.confirm_password.not_match': 'Confirm password not match',
      'login.has_account': 'Have an account, go to login',
      'login.no_account': 'No account, go to register',
      'login.username': 'Username',
      'login.username.hint': 'Please enter the username',
      'login.password': 'Password',
      'login.password.hint': 'Please enter the password',
      'login.confirm_password': 'Confirm Password',
      'login.confirm_password.hint': 'Please enter the confirm password',

      'profile.title': 'Profile',
      'profile.anonymous': 'Anonymous',
      'profile.logout': 'Logout',
      'profile.login': 'Login',
      'profile.member_card.title': 'My Account',
      'profile.member_card.btn.subscribe': 'Subscribe',
      'profile.member_card.btn.renew': 'Renew',
      'profile.member_card.remaining_tokens': 'Remaining Credits',
      'profile.member_card.vip_end': 'VIP End Time',
      'profile.settings.exchange': 'Activation Code',
      'profile.language': 'Language',
      'profile.language.en_US': 'English',
      'profile.language.zh_CN': 'Simplified Chinese',

      // 发送机器人消息页面
      'chat_detail.title': 'Send Robot Message',
      'chat_detail.hint_text': 'Please enter the message',
      'chat_detail.load_more_message': 'Load More Message',
      'chat_detail.no_more_message': 'No More Message',
      'chat_detail.has_new_message': '{count} New Message',
      'chat_detail.send_message': 'Hold to Speak',

      'activation_code.title': 'Activation Code',
      'activation_code.hint': 'Please enter the activation code',
      'activation_code.btn.exchange': 'Activate Now',
      'activation_code.btn.exchange.success': 'Activate Success',
      'activation_code.btn.exchange.failed': 'Activate Failed',
      'activation_code.rule.title': 'Activation Code Rule',
      'activation_code.rule.tip1':
          '1. The activation account is the current logged-in account, please verify the account information before activation',
      'activation_code.rule.tip2':
          '2. The activation code can only be used once, once used, it cannot be returned',

      'member.card.title': 'VIP Member',
      'member.card.tip': 'Unlock shared gift registers and other privileges',
      'member.card.btn.buy': 'Subscribe',
      'member.card.tip.subscription':
          'Subscribe to enjoy: your exclusive privileges, never discounted!',

      'member.privilege.title': 'Member Privileges',
      'member.privilege.massive.volume': 'Generous Conversation Quota',
      'member.privilege.massive.volume.tip':
          'Enjoy 100,000 credits monthly for deep and extensive AI dialogues, empowering you to explore every idea without limits.',
      'member.privilege.unlimited.creation': 'Unlimited Role Creation',
      'member.privilege.unlimited.creation.tip':
          'Create and publish up to 20 exclusive roles, build your personal AI role empire, and showcase your limitless creativity.',
      'member.privilege.deep.knowledge': 'Deep Knowledge Base Support',
      'member.privilege.deep.knowledge.tip':
          'Each role can upload up to 10 exclusive files, build a more professional and accurate AI brain, and unlock high-quality conversations.',
      'member.privilege.exclusive.access': 'Exclusive Role Library Pass',
      'member.privilege.exclusive.access.tip':
          'Access the rich and diverse third-party role market without restrictions, experience high-quality roles created by elite creators with just one click, and discover more fun.',
      'member.privilege.early.access': 'Early Access to New Features',
      'member.privilege.early.access.tip':
          'Experience the latest products and features ahead of others, feel the cutting-edge charm of AI technology, and become our chief experience officer.',
      'member.privilege.priority.support': 'Priority Support Channel',
      'member.privilege.priority.support.tip':
          'Enjoy priority technical support, quick response, and more efficient problem-solving.',
      'member.privilege.service': 'Member Service',
      'member.privilege.service.agreement': 'Member Service Agreement',
      'member.privilege.service.faq': 'Member FAQ',
      'member.privilege.activation.code': 'Use Activation Code',
      'member.privilege.service.terms': 'Terms of service',
      'member.privilege.service.auto.renewal': 'Automatic renewal rules',
      'member.privilege.service.privacy': 'Privacy Policy',
      'member.privilege.auto.renewal.subscription.terms':
          'Automatic renewal rules',

      'settings.account.title': 'Delete account',
      'settings.delete.account.title': 'Confirm Account Deletion',
      'settings.delete.account.tip':
          'Your account data (including personal information, usage records, and purchased membership benefits) will be permanently erased and unrecoverable, with active subscriptions terminated immediately without refund. Locally cached data (e.g. temporary files) must be manually cleared. This action is irreversible – ensure critical data is backed up before proceeding!',
      'settings.delete.account.success.title': 'Account Deleted Successfully',
      'settings.delete.account.failed.title': 'Account Deleted Failed',
      'settings.delete.account.success.tip':
          'Your account has been successfully deleted, and all associated data has been removed from our system. If you have any questions, please contact customer support at: cheenoalive@gmail.com',

      // 未登录页面
      'need_login.tip': 'Need Login',
      'need_login.btn.login': 'Go Login',

      'no_data': 'No Data',

      'anonymous': 'Anonymous',
    },
  };
}
